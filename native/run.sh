#!/bin/sh
wget http://www.cs.virginia.edu/stream/FTP/Code/stream.c
gcc -O3 stream.c -o stream
./stream >> /results/stream.log
sysbench --test=cpu --cpu-max-prime=20000 --num-threads=2 run >> /results/sysbench-cpu-small.log
sysbench --test=cpu --cpu-max-prime=80000 --num-threads=2 run >> /results/sysbench-cpu-large.log
sysbench --test=fileio --file-total-size=5G prepare
sysbench --test=fileio --file-total-size=5G --file-test-mode=rndrd --init-rng=on --max-time=300 --max-requests=0 run >> /results/sysbench-file-randread.log
sysbench --test=fileio --file-total-size=5G cleanup
sysbench --test=fileio --file-total-size=5G prepare
sysbench --test=fileio --file-total-size=5G --file-test-mode=rndwr --init-rng=on --max-time=300 --max-requests=0 run >> /results/sysbench-file-randwrite.log
sysbench --test=fileio --file-total-size=5G cleanup
sysbench --test=fileio --file-total-size=5G prepare
sysbench --test=fileio --file-total-size=5G --file-test-mode=seqwr --init-rng=on --max-time=300 --max-requests=0 run >> /results/sysbench-file-seqwrite.log
sysbench --test=fileio --file-total-size=5G cleanup
sysbench --test=fileio --file-total-size=5G prepare
sysbench --test=fileio --file-total-size=5G --file-test-mode=seqrd --init-rng=on --max-time=300 --max-requests=0 run >> /results/sysbench-file-seqread.log
sysbench --test=fileio --file-total-size=5G cleanup
