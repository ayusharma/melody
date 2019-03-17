#!/bin/bash

set -e

echo "$@"

for ARG in "$@"; do
  if [[ $ARG == *"nvm"* ]]; then
    sh -c  "source /root/.bashrc && $ARG | sed "s/^\([\"']\)\(.*\)\1\$/\2/g""
  else
    $ARG
  fi
done
