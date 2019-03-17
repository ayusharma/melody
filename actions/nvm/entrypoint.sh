#!/bin/bash

set -e

echo "$@"

for ARG in "$@"; do
  if [[ $ARG == *"nvm"* ]]; then
    C = echo $ARG
    bash -c "source /usr/local/nvm/nvm.sh && $C"
  else
    $ARG
  fi
done
