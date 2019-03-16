#!/bin/bash

set -e

source /usr/local/nvm/nvm.sh
source /root/.profile
source /root/.bashrc

bash -c "nvm"

# for ARG in "$@"; do
#     $ARG
# done