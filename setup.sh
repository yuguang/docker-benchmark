#!/bin/sh
wget http://www.coker.com.au/bonnie++/bonnie++-1.03e.tgz
tar zxvf bonnie++-1.03e.tgz
cd bonnie++-1.03e
./configure
make
make install

emerge iperf sysbench

wget http://www.cs.virginia.edu/stream/FTP/Code/stream.c
gcc -O3 stream.c -o stream