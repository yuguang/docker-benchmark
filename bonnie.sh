#!/usr/bin/env bash
# filesize must be at least double the amount of RAM for -s
bonnie++ -s 1g -x 10 -u root > bonnie.log
bonnie++ -s 1k -x 10 -u root > bonnie.log