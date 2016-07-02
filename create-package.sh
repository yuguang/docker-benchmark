#!/usr/bin/env bash
tar czf docker-bench-i686.tar.gz setup.sh run.sh collect.sh
tar czf docker-bench-native.tar.gz native/setup.sh native/run.sh native/collect.sh