#!/bin/bash

# This unzips downloaded sub-sites, if present, and copies them to the site

# Define text formatting variables
RESET='\033[0m'
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BOLD='\033[1m'
STAR=⭐
FIRE=🔥
EXPLOSION=💥

# Access passed arguments
out_path=$1
extract_dir=$2
styles_dir=$3
index_html=$4
zip_extension=$5
clear_exports=$6
dry_run=$7

# Get the full directory where the script is located
script_path="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo -e "${GREEN}${BOLD}Reticulating splines at: $script_path${RESET}"

# Change to the script's directory
cd "$script_path" || exit

# unzip *.zip export
rm -rf "$extract_dir"
unzip *"$zip_extension"

# temporarily move index.html & /styles out, copy remaining contents to output location, then move them back
mv "$extract_dir/$index_html" .
mv "$extract_dir/$styles_dir" .
cp -rf "$extract_dir"/* "$out_path"


# Add delay before moving back so that the following isn't done before everything is copied
sleep 2

echo -e "${BOLD}${YELLOW}Reinstating downloaded Zip extractions${RESET}"
mv "$index_html" "$extract_dir"
mv "$styles_dir" "$extract_dir"

echo -e "${BOLD}${YELLOW}Clear exports? ${RED}$clear_exports${RESET}"
# Clear downloaded files, or reinstate extracted results
if [[ "$clear_exports" == "true" && "$dry_run" != "true" ]]; then
	sleep 2
    echo -e "${FIRE}${FIRE}${RED}${BOLD} clear_exports is set to 'true'. Removing any extracted directories ${FIRE}${FIRE}${RESET}"

    # Remove the directory and all its contents
    if [[ -d "$extract_dir" ]]; then
        echo -e "${BOLD}${EXPLOSION}${EXPLOSION}${RED} Removing directory:${RESET} $extract_dir ${EXPLOSION}${EXPLOSION}${RESET}"
        rm -rf "$extract_dir"
    else
        echo -e "${BOLD}Directory not found:${RESET} $extract_dir"
    fi
else
	echo -e ${BOLD}${YELLOW}"Not today, friend, not today...${RESET}"
fi

echo -e "${STAR}${STAR}${STAR}${GREEN}${BOLD} Splines reticulated ${STAR}${STAR}${STAR}${RESET}"
echo ""