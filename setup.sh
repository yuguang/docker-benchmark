#!/bin/sh
emerge --autounmask-write -v =app-emulation/containerd-0.2.0 =app-emulation/runc-0.1.0 =app-emulation/docker-1.11.0
yes | etc-update --automode -3
emerge -v =app-emulation/containerd-0.2.0 =app-emulation/runc-0.1.0 =app-emulation/docker-1.11.0
/etc/init.d/docker restart
git clone https://github.com/yuguang/docker-benchmark
mkdir /results
chmod -R 777 /results