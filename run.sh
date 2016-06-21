#!/bin/sh
docker build -t benchmark .
docker run -v /results:/results benchmark ./benchmark.sh