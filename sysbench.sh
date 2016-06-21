#!/usr/bin/env bash
sysbench --test=cpu --cpu-max-prime=20000 --num-threads=2 run > /results/sysbench-small.log
sysbench --test=cpu --cpu-max-prime=80000 --num-threads=2 run > /results/sysbench-large.log