#!/bin/sh
wget http://www.coker.com.au/bonnie++/bonnie++-1.03e.tgz
tar zxvf bonnie++-1.03e.tgz
cd bonnie++-1.03e
./configure
make
make install

if ((1<<32)); then
    sudo apt-get remove iperf3 libiperf0
    wget https://iperf.fr/download/ubuntu/libiperf0_3.1.2-1_amd64.deb
    wget https://iperf.fr/download/ubuntu/iperf3_3.1.2-1_amd64.deb
    sudo dpkg -i libiperf0_3.1.2-1_amd64.deb iperf3_3.1.2-1_amd64.deb
    rm libiperf0_3.1.2-1_amd64.deb iperf3_3.1.2-1_amd64.deb
else
    sudo apt-get remove iperf3 libiperf0
    wget https://iperf.fr/download/ubuntu/libiperf0_3.1.2-1_i386.deb
    wget https://iperf.fr/download/ubuntu/iperf3_3.1.2-1_i386.deb
    sudo dpkg -i libiperf0_3.1.2-1_i386.deb iperf3_3.1.2-1_i386.deb
    rm libiperf0_3.1.2-1_i386.deb iperf3_3.1.2-1_i386.deb
fi
sudo apt-get install sysbench

mkdir /results
chmod -R 777 /results