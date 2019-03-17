#!/bin/bash

set -e

source $NVM_DIR/nvm.sh

for ARG in "$@"; do
  $ARG
done
