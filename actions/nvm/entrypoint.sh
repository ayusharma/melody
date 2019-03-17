#!/bin/bash

set -e

# for var in "$@"
# do
#     echo $var
#     sh -c "$var"
# done

array=("$@")

for i in "${array[@]}"
do
	echo $i
  sh -c "$i"
done