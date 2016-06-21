#!/bin/sh
results="results.tar.gz"
tar czf $results /results/*log
echo $results