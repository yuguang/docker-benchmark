#!/usr/bin/env bash
sysbench --test=cpu --cpu-max-prime=20000 --num-threads=2 run > /results/sysbench-small.log
sysbench --test=cpu --cpu-max-prime=80000 --num-threads=2 run > /results/sysbench-large.log
sysbench --test=fileio --file-total-size=5G prepare
sysbench --test=fileio --file-total-size=5G --file-test-mode=rndrd --init-rng=on --max-time=300 --max-requests=0 run
sysbench --test=fileio --file-total-size=5G --file-test-mode=rndwr --init-rng=on --max-time=300 --max-requests=0 run
sysbench --test=fileio --file-total-size=5G --file-test-mode=seqwr --init-rng=on --max-time=300 --max-requests=0 run
sysbench --test=fileio --file-total-size=5G --file-test-mode=seqrd --init-rng=on --max-time=300 --max-requests=0 run
sysbench --test=fileio --file-total-size=5G cleanup
