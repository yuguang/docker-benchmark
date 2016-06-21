#!/bin/sh
docker build -t benchmark .
docker run -v /var/log:/results benchmark