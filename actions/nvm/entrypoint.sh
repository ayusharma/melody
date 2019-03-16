#!/bin/bash

set -e

source /usr/local/nvm/nvm.sh
source /root/.profile
source /root/.bash_profile
source /root/.bashrc

for ARG in "$@"; do
    $ARG
done