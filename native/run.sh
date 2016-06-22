#!/bin/sh
cd ~
git clone https://github.com/yuguang/docker-benchmark
cd docker-benchmark
chmod +x *.sh
./benchmark.sh