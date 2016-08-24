#!/bin/sh
cat > sysbench-single.sh <<EOF
#!/bin/sh
cd /results
sysbench --test=fileio --file-total-size=5G prepare
sysbench --test=fileio --file-total-size=5G --file-test-mode=rndrd --init-rng=on --max-time=300 --max-requests=0 run >> /results/sysbench-file-randread.log
sysbench --test=fileio --file-total-size=5G cleanup
EOF
sudo docker build -t benchmark .
sudo docker run -v /results:/results benchmark ./sysbench-single.sh
sudo mkfs.btrfs -f /dev/sda1
sudo mount /dev/sda1 /mnt/benchmark/
cat > sysbench-single.sh <<EOF
#!/bin/sh
cd /benchmark
sysbench --test=fileio --file-total-size=5G prepare
sysbench --test=fileio --file-total-size=5G --file-test-mode=rndwr --init-rng=on --max-time=300 --max-requests=0 run >> /results/sysbench-file-randwrite.log
sysbench --test=fileio --file-total-size=5G cleanup
EOF
sudo docker build -t benchmark .
sudo docker run -v /results:/results -v /mnt/benchmark:/benchmark benchmark ./sysbench-single.sh
sudo docker rmi -f benchmark
sudo umount /mnt/benchmark/

sudo mkfs.btrfs -f /dev/sda1
sudo mount /dev/sda1 /mnt/benchmark/
cat > sysbench-single.sh <<EOF
#!/bin/sh
cd /benchmark
sysbench --test=fileio --file-total-size=5G prepare
sysbench --test=fileio --file-total-size=5G --file-test-mode=seqwr --init-rng=on --max-time=300 --max-requests=0 run >> /results/sysbench-file-seqwrite.log
sysbench --test=fileio --file-total-size=5G cleanup
EOF
sudo docker build -t benchmark .
sudo docker run -v /results:/results -v /mnt/benchmark:/benchmark benchmark ./sysbench-single.sh
sudo docker rmi -f benchmark
sudo umount /mnt/benchmark/

sudo mkfs.btrfs -f /dev/sda1
sudo mount /dev/sda1 /mnt/benchmark/
cat > sysbench-single.sh <<EOF
#!/bin/sh
cd /benchmark
sysbench --test=fileio --file-total-size=5G prepare
sysbench --test=fileio --file-total-size=5G --file-test-mode=seqrd --init-rng=on --max-time=300 --max-requests=0 run >> /results/sysbench-file-seqread.log
sysbench --test=fileio --file-total-size=5G cleanup
EOF
sudo docker build -t benchmark .
sudo docker run -v /results:/results -v /mnt/benchmark:/benchmark benchmark ./sysbench-single.sh
sudo docker rmi -f benchmark
sudo umount /mnt/benchmark/
