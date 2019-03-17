#!/bin/bash

set -e

for var in "$@"
do
    echo "$var" | bash
done
