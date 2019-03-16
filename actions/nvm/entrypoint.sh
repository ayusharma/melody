#!/bin/bash

set -e

source /root/.nvm/nvm.sh
source /root/.profile
source /root/.bashrc

sh -c "nvm"

# for ARG in "$@"; do
#     $ARG
# done