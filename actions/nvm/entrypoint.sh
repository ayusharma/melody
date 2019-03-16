#!/bin/bash

set -e

source /root/.bashrc
source /usr/local/nvm/nvm.sh

for ARG in "$@"; do
    $ARG
done