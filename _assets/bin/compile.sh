#!/bin/bash

# This invokes all push.sh scripts in the staging directory & subdirectories, compiling all downloaded files to the site

# Read local config
config_file="config.txt"

# Use grep and cut to extract values
# Site variables    
site_path=$(grep 'site_path' "$config_file" | cut -d'=' -f2)
site_dir=$(grep 'site_dir' "$config_file" | cut -d'=' -f2)
site_wiki_dir=$(grep 'site_wiki_dir' "$config_file" | cut -d'=' -f2)

# Download variables
extract_dir=$(grep 'extract_dir' "$config_file" | cut -d'=' -f2)

# Other Variables
zip_extension=$(grep 'zip_extension' "$config_file" | cut -d'=' -f2)
styles_dir=$(grep 'styles_dir' "$config_file" | cut -d'=' -f2)
index_html=$(grep 'index_html' "$config_file" | cut -d'=' -f2)
home_dir=$(grep 'home_dir' "$config_file" | cut -d'=' -f2)
assets_dir=$(grep 'assets_dir' "$config_file" | cut -d'=' -f2)
push_sh=$(grep 'push_sh' "$config_file" | cut -d'=' -f2)

# Text formatting variables
RESET=$(grep 'RESET' "$config_file" | cut -d'=' -f2)
RED=$(grep 'RED' "$config_file" | cut -d'=' -f2)
GREEN=$(grep 'GREEN' "$config_file" | cut -d'=' -f2)
YELLOW=$(grep 'YELLOW' "$config_file" | cut -d'=' -f2)
BOLD=$(grep 'BOLD' "$config_file" | cut -d'=' -f2)
PARTY=$(grep 'PARTY' "$config_file" | cut -d'=' -f2)


echo "site_path=${site_path}"
echo "site_dir=${site_dir}"
echo "site_wiki_dir=${site_wiki_dir}"
echo "extract_dir=${extract_dir}"

out_path="${site_path}/${site_dir}/${site_wiki_dir}"

# Arguments
clear_exports=false
dry_run=false

# Get the full directory where the script is located
script_path="$(cd "$(dirname "$0")" && pwd)"

echo "${BOLD}${GREEN}Pushing your exported wiki to prod!${RESET}"

# Function to display usage
usage() {
    echo "Usage: $0 --clear-exports=true|false --dry-run=true|false"
    exit 1
}

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -d|--dry-run)
            dry_run=true
            shift ;;  # move to the next argument
        -c|--clear-exports)
            clear_exports=true
            shift ;;  # move to the next argument
        *) 
            echo "Unknown option: $1"
            exit 1 ;;
    esac
done

# Print the values for confirmation
echo "${YELLOW}clear_exports:${RESET} $clear_exports"
echo "${YELLOW}dry_run:${RESET} $dry_run"

# Change to the script's directory
cd "$script_path" || exit   

if [[ "$dry_run" == "true" ]]; then
    # If dry run, make new temporary location to build a simulation of the exported site
	#	Create new dir one level above called {dir name}_dry_run	
	directory_name=$(basename "$script_path")
	dry_dir="${directory_name}_dry_run"

	parent_directory=$(dirname "$script_path")
	out_path="${parent_directory}/${dry_dir}"

	# 	Copy assets from _assets
	mkdir -p $out_path
	cp -rf "../${assets_dir}/assets" "${out_path}/assets"

	#	Create child /wiki dir and copy syles to it from _assets
	out_path="${out_path}/${site_wiki_dir}"
	mkdir -p $out_path
	cp -rf "../${assets_dir}/styles/*" "${out_path}/styles"
else
    echo "Initializing Dir at: $out_path"
    # TODO: Remove dir
    rm -rf $out_path
    mkdir -p $out_path
    parent_path="$(dirname "$script_path")"
    cp -rf "$parent_path/${assets_dir}/styles" "${out_path}/styles"
fi

# Strip the extension from $push_sh (i.e., get "push" from "push.sh")
prefix="${push_sh%.sh}"
echo "prefix: $prefix"

# Set the Internal Field Separator to newline to handle filenames with spaces
IFS=$'\n'

# Find files and store them with both filename and full path
matched_files=$(find . -type f -name "${prefix}*.sh" -print0 | xargs -0 -I {} bash -c 'echo "$(basename "$1") $1"' _ {} | sort)

# Check if any matching files were found
if [[ -z "$matched_files" ]]; then
    echo "No files named '$prefix' found in the script directory or its subdirectories."
    exit 1
fi

# Iterate over the matched files
for entry in $matched_files; do
    # Extract the filename and full path from each sorted entry
    #filename=$(echo "$entry" | awk '{print $1}')
    file_path=$(echo "$entry" | awk '{print $2}')

    echo "Executing script at: $file_path"
    
    # Make the file executable, if it's not already
    chmod +x "$file_path"
    
    # Execute the script with the remaining arguments
    bash "$file_path" "$out_path" "$extract_dir" "$styles_dir" "$index_html" "$zip_extension" "$clear_exports" "$dry_run"
    
    echo "Finished executing: $file_path"
done

# Copy over Root index.html for entry
sleep 2

cp -rf "$script_path/$home_dir/$extract_dir/$index_html" "$out_path"

echo ""
echo "${PARTY}${PARTY}${PARTY}${PARTY}${PARTY}${RESET}"
echo "${YELLOW}Wiki exported to the following location:${RESET} $out_path"
echo "${PARTY}${PARTY}${PARTY}${PARTY}${PARTY}${RESET}"
echo ""
echo "${PARTY}${PARTY}${BOLD}${GREEN} Finished executing all scripts. Enjoy your updated wiki! ${PARTY}${PARTY}${RESET}"