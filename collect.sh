#!/bin/sh
results="$HOSTNAME-docker.tar.gz"
tar czf $results /results/*log
rm -rf /results/*

# run the native benchmark
wget http://www.coker.com.au/bonnie++/bonnie++-1.03e.tgz
tar zxvf bonnie++-1.03e.tgz
cd bonnie++-1.03e
./configure
make
make install

emerge iperf sysbench

./benchmark.sh

results="$HOSTNAME-native.tar.gz"
tar czf $results /results/*log

tar czf results.tar.gz *.tar.gz

echo "results.tar.gz"