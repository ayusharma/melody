#!/bin/bash

set -e

source /usr/local/nvm/.nvm/nvm.sh
source /root/.profile
source /root/.bashrc

sh -c "nvm"

# for ARG in "$@"; do
#     $ARG
# done