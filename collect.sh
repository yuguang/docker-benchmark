#!/bin/sh
results="results="$HOSTNAME-docker.tar.gz"
tar czf $results /results/*log
echo $results