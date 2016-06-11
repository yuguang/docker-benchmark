#!/usr/bin/env bash
# filesize must be at least double the amount of RAM for -s
# number:max:min:num-directories
bonnie++ -n 16:1024:512:1 -x 10 -u root > bonnie.log