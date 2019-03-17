#!/bin/bash

set -e

echo "$@"

for ARG in "$@"; do
  $ARG
done
