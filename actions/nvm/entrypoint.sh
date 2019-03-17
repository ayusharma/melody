#!/bin/bash

set -e

echo "$@"

for ARG in "$@"; do
  if [[ $ARG == *"nvm"* ]]; then
    echo "source /usr/local/nvm/nvm.sh && $ARG" | bash
  else
    $ARG
  fi
done
