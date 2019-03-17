#!/bin/bash

set -e

echo "$@"

for ARG in "$@"; do
  echo "$ARG"
  $ARG
done
