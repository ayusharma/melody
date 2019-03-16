#!/bin/bash

set -e

exec bash
source /root/.bashrc
source /usr/local/nvm/nvm.sh

for ARG in "$@"; do
    $ARG
done