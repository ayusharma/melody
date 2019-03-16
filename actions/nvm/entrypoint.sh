#!/bin/bash

set -e

. /root/.bashrc

for ARG in "$@"; do
    $ARG
done