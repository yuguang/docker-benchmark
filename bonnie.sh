#!/usr/bin/env bash
# filesize must be at least double the amount of RAM for -s
bonnie++ -x 10  -r 1024 -u root>>/results/bonnie.log 2>&1