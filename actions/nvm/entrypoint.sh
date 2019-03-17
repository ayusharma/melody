#!/bin/bash

set -e

# install https://github.com/tj/n
sh -c "npm install -g n"
sh -c "n -V"

sh -c "$*"
