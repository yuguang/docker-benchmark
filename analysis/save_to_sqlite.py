#!/usr/bin/python

import tarfile
import sys
import os
import re
import tempfile
import json
import shutil
import sqlite3, subprocess
import re
import sys

sys.path.append('/home/yuguang/Projects/performance_tools')
from performance_tools.result_processor import ResultProcessor, Utils


def has_nan(l):
    for s in l:
        if s.strip() == "inf":
            return False
        if s.strip() == "-nan" or s.strip() == "nan":
            return True

    return False


def process_logs(log):


    result_table_machine = []
    result_table_machine.append("name,usec_per_call".split(","))
    config_table = []
    config_table.append("key,value".split(","))

    content = log.split("\n")
    sysc_group = None
    for line in content:
        if not line.startswith(("#")):
            splitted = line.split(",")
            try:
                if "Segmentation fault" in line:
                    r = re.findall(r'"(.+)"', line)
                    result_table_machine.append([r[0], -1])
                    continue
                if has_nan(splitted):
                    result_table_machine.append([splitted[0].strip(), -1])
                    continue
                if line.startswith("Mutex") or line.startswith("Warning:"):
                    continue
            except:
                pass

            # if size is less than 4, then ignore it
            if line.startswith("!"):
                sp = line.split(":")
                config_table.append([sp[0].replace("!", "").strip(), sp[1].strip()])
                continue
            if line == " ":
                sysc_group = None
                continue
            if len(splitted) < 4:
                continue
            if sysc_group is None:
                if "_" not in line:
                    spl = line
                    sysc_group = splitted[0].strip()
                else:
                    spl = splitted[0].strip().split("_")
                    if len(spl) > 1:
                        sysc_group = "_".join(spl)
                    else:
                        sysc_group = spl[0]
            result_table_machine.append([splitted[0].strip(), splitted[3].strip()])

    results = {
        "result_table": result_table_machine,
        "config_table": config_table
    }

    return results


def process(args):
    [in_filename, out_filename] = args

    # print(in_filename)

    EXTRACT_PATH = tempfile.mkdtemp()

    tar = tarfile.open(in_filename)
    tar.extractall(path=EXTRACT_PATH)
    tar.close()

    result_files = []
    os.chdir(EXTRACT_PATH)
    subprocess.check_call("""cat *.log | egrep " cat|threads:|transactions|deadlocks|read/write|min:|avg:|max:|percentile:" | tr -d "\n" | sed 's/Number of threads: /\n/g' | sed 's/\[/\n/g' | sed 's/[A-Za-z\/]\{1,\}://g'| sed 's/ \.//g' | sed -e 's/read\/write//g' -e 's/approx\.  95//g' -e 's/per sec.)//g' -e 's/ms//g' -e 's/(//g' -e 's/^.*cat //g' | sed 's/ \{1,\}/\t/g' >> system.csv""", shell=True)
    for dirpath, dirnames, filenames in os.walk(EXTRACT_PATH):
        filenames = map(lambda path: os.path.join(dirpath, path), filenames)
        for filename in filenames:
            if not filename.startswith('sysbench'):
                result_files.extend(filenames)

    for result_file in result_files:
        bench_results = process_logs(open(result_file, "r").read())
        json.dump(bench_results, open(out_filename, "w"))

    return (EXTRACT_PATH, out_filename)


def concatenate(args):
    [result_file, job_id, database_file] = args

    # read json file
    with open(result_file, "r") as job_file:
        job_results = json.load(job_file)

    if job_results == {}:
        return

    meta = {'job_id': job_id}

    database = sqlite3.connect(database_file)
    table = Utils.table_flatten(job_results['result_table'])
    config_table = Utils.table_flatten(job_results['config_table'])

    if not len(table):
        return
    # add job_id to the header
    header = sorted(meta.keys()) + sorted(table[0].keys())
    config_header = sorted(meta.keys()) + sorted(config_table[0].keys())

    # add job id to each element of the table data list
    list(map(lambda row: row.update(meta), table))
    list(map(lambda row: row.update(meta), config_table))

    # create table if not exists1`
    Utils.create_table(database, "result_table", header)
    Utils.create_table(database, "config_table", config_header)

    # insert data to the table
    Utils.insert_data(database, "result_table", header, table)
    Utils.insert_data(database, "config_table", config_header, config_table)

    # commit the change
    database.commit()

    # close database
    database.close()


if __name__ == "__main__":
    experiment_id = sys.argv[1]

    in_filename = "experiment_{}_results.tar".format(experiment_id)
    out_filename = "./out.json"

    processor = ResultProcessor(
            process=process,
            concatenate=concatenate
    )

    args = [in_filename, out_filename]

    processor.main("./experiment_{}".format(experiment_id), "db.sqlite", parallel=False)
