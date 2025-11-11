#!/bin/bash
robot -v browser=$1 \
--outputdir test_results/$1 \
--name "$1" \
tests