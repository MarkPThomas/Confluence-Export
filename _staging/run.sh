#!/bin/bash

# Define text formatting variables
RESET='\033[0m'
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BOLD='\033[1m'
PARTY='🎉'

out_path="/Users/markthomas/coding/MarkPThomas.github.io/wiki/"
#out_path="/Users/markthomas/downloads/Wiki/mark.ly_prod/wiki/"
export_dir="MARKPTHOMA"
zip_extension=".html.zip"
styles_dir="styles"
index_html="index.html"
home_dir="_home"
push_sh="push.sh"

assets_dir="_assets"

# Arguments
clear_exports=false
dry_run=false

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

# If dry run, make new temporary location to build a simulation of the exported site
if [[ "$dry_run" == "true" ]]; then
	# Get the full directory where the script is located
	script_path="$(cd "$(dirname "$0")" && pwd)"

	# Change to the script's directory
	cd "$script_path" || exit


	#	Create new dir one level above called {dir name}_dry_run	
	directory_name=$(basename "$script_path")
	dry_dir="${directory_name}_dry_run"

	parent_directory=$(dirname "$script_path")
	out_path="${parent_directory}/${dry_dir}"

	# 	Copy assets from _assets
	mkdir $out_path
	cp -rf "../${assets_dir}/assets" "${out_path}/assets"

	#	Create child /wiki dir and copy syles to it from _assets
	out_path="${out_path}/wiki"
	mkdir $out_path
	cp -rf "../${assets_dir}/styles/*" "${out_path}/styles"
fi

# Find the file in the current directory and all child directories
file_paths=$(find . -type f -name "$push_sh")

# Check if any matching files were found
if [[ -z "$file_paths" ]]; then
    echo "No files named '$push_sh' found in the script directory or its subdirectories."
    exit 1
fi

# Iterate over each file found and execute it with the passed arguments
for file_path in $file_paths; do
    echo "Executing script at: $file_path"
    
    # Make the file executable, if it's not already
    chmod +x "$file_path"
    
    # Execute the script with the remaining arguments
    bash "$file_path" "$out_path" "$export_dir" "$styles_dir" "$index_html" "$zip_extension" "$clear_exports" "$dry_run"
    
    echo "Finished executing: $file_path"
done

# Copy over Root index.html for entry
sleep 2

script_path="$(cd "$(dirname "$0")" && pwd)"
cp -rf "$script_path/$home_dir/$export_dir/$index_html" "$out_path"

echo ""
echo "${PARTY}${PARTY}${PARTY}${PARTY}${PARTY}${RESET}"
echo "${YELLOW}Wiki exported to the following location:${RESET} $out_path"
echo "${PARTY}${PARTY}${PARTY}${PARTY}${PARTY}${RESET}"
echo ""
echo "${PARTY}${PARTY}${BOLD}${GREEN} Finished executing all scripts. Enjoy your updated wiki! ${PARTY}${PARTY}${RESET}"