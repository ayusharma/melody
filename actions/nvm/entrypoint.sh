#!/bin/bash

set -e

echo "$@"

for ((i=0;i<=$#;i++)); do echo "${!i}" | bash ; done
