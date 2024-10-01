#!/bin/bash

# This removes all zipped AND unzipped directories

# Read local config
config_file="config.txt"

# Use grep and cut to extract values
extract_dir=$(grep 'extract_dir' "$config_file" | cut -d'=' -f2)
zip_extension=$(grep 'zip_extension' "$config_file" | cut -d'=' -f2)

# Text formatting variables
RESET=$(grep 'RESET' "$config_file" | cut -d'=' -f2)
RED=$(grep 'RED' "$config_file" | cut -d'=' -f2)
YELLOW=$(grep 'YELLOW' "$config_file" | cut -d'=' -f2)
BOLD=$(grep 'BOLD' "$config_file" | cut -d'=' -f2)
FIRE=$(grep 'FIRE' "$config_file" | cut -d'=' -f2)
EXPLOSION=$(grep 'EXPLOSION' "$config_file" | cut -d'=' -f2)

# Get the absolute path of the current directory
script_path="$(pwd)"

# Remove all subdirectories of the given name within the copied directory
echo "$FIRE$FIRE$RED$BOLD Nuking.... Removing the zip file & any extracted directories $FIRE$FIRE$RESET"

echo "$BOLD$EXPLOSION$EXPLOSION$YELLOW Removing all instances of directory:$RESET $extract_dir from $script_path $EXPLOSION$EXPLOSION$RESET"
find "$script_path" -type d -name "$extract_dir" -exec rm -r {} +

echo "$BOLD$EXPLOSION$EXPLOSION$REDRemoving all instances of zip file:$RESET $zip_extension from $script_path $EXPLOSION$EXPLOSION$RESET"
find "$script_path" -type f -name *$zip_extension -exec rm -r {} +