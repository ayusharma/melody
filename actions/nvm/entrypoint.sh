#!/bin/bash

set -e

for ARG in "$@"; do

  if [[ $ARG == *"nvm"* ]]; then
    source /usr/local/nvm/nvm.sh && $ARG
  else
    $ARG
  fi
  
done
