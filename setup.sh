#!/bin/sh
emerge --autounmask-write -v =app-emulation/containerd-0.2.0 =app-emulation/runc-0.1.0 =app-emulation/docker-1.11.0
yes | etc-update --automode -3
emerge -v =app-emulation/containerd-0.2.0 =app-emulation/runc-0.1.0 =app-emulation/docker-1.11.0
/etc/init.d/docker restart
mkdir /results
chmod -R 777 /results
mkdir /mnt/benchmark
if ((1<<32)); then
    mv Dockerfile-64 Dockerfile
fi