#!/bin/bash

set -e

source /usr/local/nvm/nvm.sh

for ARG in "$@"; do
  $ARG
done
