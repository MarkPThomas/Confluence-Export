#!/bin/bash

# Read local config
config_file="config.txt"

# Use grep and cut to extract values
assets_dir=$(grep 'assets_dir' "$config_file" | cut -d'=' -f2)
push_sh=$(grep 'push_sh' "$config_file" | cut -d'=' -f2)

# This updates the associated staging directory with updated scripts from _assets/bin

# Get the full directory where the script is located
script_path="$(cd "$(dirname "$0")" && pwd)"

# Change to the script's directory
cd "$script_path" || exit

# Source file and path
parent_path="$(dirname "$(pwd)")"
source_path="$parent_path/$assets_dir/bin/$push_sh"

# Update child scripts
# Ensure the source file exists
if [[ ! -f "$source_path" ]]; then
    echo "Source file not found at $source_path"
    exit 1
fi

# Strip the extension from $push_sh (i.e., get "push" from "push.sh")
prefix="${push_sh%.sh}"
echo "prefix: $prefix"

# Search for files with the same name and copy the source file over them
#find . -type f -name "$push_sh" -exec cp "$source_path" {} \;
find . -type f -name "$prefix*" -exec sh -c '
    for target; do
        echo "target: $target"
        # Copy the source file over the target file, but keep the target file name
        cp "$1" "$target"
    done
' sh "$source_path" {} +

# Update root scripts
rsync -av --exclude="$push_sh" --exclude="$config_file" "$parent_path/$assets_dir/bin"/* .
