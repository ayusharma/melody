#!/bin/bash

set -e

for ARG in "$@"; do
  sh -c 'source /usr/local/nvm/nvm.sh && $ARG'
done
