#!/bin/bash

set -e

echo "$@"

for ARG in "$@"; do
  if [[ $ARG == *"nvm"* ]]; then
    bash -c "source /usr/local/nvm/nvm.sh && ($ARG)"
  else
    $ARG
  fi
done
