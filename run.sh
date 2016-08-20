#!/bin/sh
sudo docker build -t benchmark .
sudo docker run -v /results:/results benchmark ./benchmark.sh