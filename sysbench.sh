#!/usr/bin/env bash
sysbench --test=cpu --cpu-max-prime=20000 --num-threads=2 run > sysbench-small.log
sysbench --test=cpu --cpu-max-prime=200000 --num-threads=2 run > sysbench-large.log