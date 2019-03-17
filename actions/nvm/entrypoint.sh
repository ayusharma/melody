#!/bin/bash

set -e

for ARG in "$@"; do

  if [[ $ARG == *"nvm"* ]]; then
    sh -c "source /usr/local/nvm/nvm.sh && $ARG"
  else
    sh -c "$ARG"
  fi
  
done
