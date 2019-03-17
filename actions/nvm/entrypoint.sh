#!/bin/bash

set -e

# install https://github.com/tj/n
sh -c "npm install -g n"
sh -c "n -V"

array=("$@")

for i in "${array[@]}"
do
	echo $i
  sh -c "$i"
done