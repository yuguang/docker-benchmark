#!/usr/bin/env bash
wget http://www.cs.virginia.edu/stream/FTP/Code/stream.c
gcc -O3 stream.c -o stream
./stream > /results/stream.log