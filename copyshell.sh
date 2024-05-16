#!/bin/bash

# Define the file path
file="/home/808fsemti/projects/flake.nix"
copy_file="$(basename "$file")"

cp $file $copy_file