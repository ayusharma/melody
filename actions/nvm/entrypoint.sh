#!/bin/bash

set -e

echo "$@"

for ARG in "$@"; do
  if [[ $ARG == *"nvm"* ]]; then
    sh -c  "source /root/.bashrc && $ARG"
  else
    $ARG
  fi
done
