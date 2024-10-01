#!/bin/bash

# This removes all unzipped directories

# Read local config
config_file="config.txt"

# Use grep and cut to extract values
extract_dir=$(grep 'extract_dir' "$config_file" | cut -d'=' -f2)

# Text formatting variables
RESET=$(grep 'RESET' "$config_file" | cut -d'=' -f2)
YELLOW=$(grep 'YELLOW' "$config_file" | cut -d'=' -f2)
BOLD=$(grep 'BOLD' "$config_file" | cut -d'=' -f2)
EXPLOSION=$(grep 'EXPLOSION' "$config_file" | cut -d'=' -f2)

# Get the absolute path of the current directory
script_path="$(pwd)"

# Remove all subdirectories of the given name within the copied directory
echo "$BOLD$EXPLOSION$EXPLOSION$YELLOW Removing all instances of directory:$RESET $extract_dir from $script_path $EXPLOSION$EXPLOSION$RESET"
find "$script_path" -type d -name "$extract_dir" -exec rm -r {} +