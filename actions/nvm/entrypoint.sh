#!/bin/bash

set -e

for var in "$@"
do
    echo $var
    sh -c "$var"
done
