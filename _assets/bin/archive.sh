#!/bin/bash

# This copies the staging dir to an archive directory for recovery

# Read local config
config_file="config.txt"

# Use grep and cut to extract values
# Site variables    
site_path=$(grep 'site_path' "$config_file" | cut -d'=' -f2)
site_dir=$(grep 'site_dir' "$config_file" | cut -d'=' -f2)
site_wiki_dir=$(grep 'site_wiki_dir' "$config_file" | cut -d'=' -f2)
extract_dir=$(grep 'extract_dir' "$config_file" | cut -d'=' -f2)
staging_wiki_dir=$(grep 'staging_wiki_dir' "$config_file" | cut -d'=' -f2)

echo "site_path=${site_path}"
echo "site_dir=${site_dir}"
echo "site_wiki_dir=${site_wiki_dir}"

temp_dir="temp"

# Get the absolute path of the current directory
current_path="$(pwd)"
source_path="$current_path"

# Get one level up
parent_path="$(dirname "$source_path")"
parent_name="$(basename "$source_path")"
zip_name="${parent_name}.zip" 

# TODO: Work out where/how to have a location
# Default is in root of Wiki export dir
out_path="$parent_path/$temp_dir"
target_path="$out_path/$parent_name"

echo "Copy"
echo "From: $source_path"
echo "To: $target_path"
echo "As: $zip_name"

# Step 1: Copy the root directory to the destination location
mkdir -p "$out_path"
cp -rf "$source_path" "$out_path" 

# Check if the copy operation was successful
if [[ $? -ne 0 ]]; then
    echo "Failed to copy directory."
    exit 1
fi

# Step 2: Remove all subdirectories of the given name within the copied directory
find "$out_path" -type d -name "$extract_dir" -exec rm -r {} +

# Step 3: Zip the root directory after cleaning it
cd "$out_path"
zip -r "$zip_name" "$parent_name"

# Check if the zip operation was successful
if [[ $? -eq 0 ]]; then
    echo "Directory successfully zipped into $zip_name"
else
    echo "Failed to zip the directory."
    exit 1
fi

# Copy zip directory up one level and remove tmp
cp -rf "$out_path/$zip_name" "$parent_path"
rm -rf "$out_path"