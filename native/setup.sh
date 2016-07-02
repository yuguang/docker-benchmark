#!/bin/sh
wget http://www.coker.com.au/bonnie++/bonnie++-1.03e.tgz
tar zxvf bonnie++-1.03e.tgz
cd bonnie++-1.03e
./configure
make
make install

emerge iperf sysbench

mkdir /results
chmod -R 777 /results