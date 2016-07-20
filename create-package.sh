#!/usr/bin/env bash
tar czf docker-bench-i686.tar.gz setup.sh run.sh collect.sh
pushd ./native
tar czf docker-bench-native.tar.gz setup.sh run.sh collect.sh
popd