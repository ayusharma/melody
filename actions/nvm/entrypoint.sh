#!/bin/bash

set -e

for ARG in "$@"; do
    $ARG
done