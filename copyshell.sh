#!/bin/bash

# Define the file path
file="/home/808fsemti/projects/shell.nix"
copy_file="$(basename "$file")"

cp $file $copy_file