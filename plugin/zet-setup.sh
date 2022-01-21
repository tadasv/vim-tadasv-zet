#!/bin/bash

path=$(dirname "$0")
filename=$("${path}/zet-name.sh")
mkdir -p z
touch $filename
echo "$filename" > z-root
