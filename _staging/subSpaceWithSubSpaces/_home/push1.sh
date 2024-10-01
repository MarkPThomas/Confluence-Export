#!/bin/bash

# Define text formatting variables
RESET='\033[0m'
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BOLD='\033[1m'
STAR='⭐'
FIRE='🔥'
EXPLOSION='💥'

# Access passed arguments
out_path=$1
export_dir=$2
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
rm -rf "$export_dir"
unzip *"$zip_extension"

# temporarily move index.html & /styles out, copy remaining contents to output location, then move them back
mv "$export_dir/$index_html" .
mv "$export_dir/$styles_dir" .
cp -rf "$export_dir"/* "$out_path"


# Add delay before moving back so that the following isn't done before everything is copied
sleep 2

echo -e "${BOLD}${YELLOW}Reinstating downloaded Zip extractions${RESET}"
mv "$index_html" "$export_dir"
mv "$styles_dir" "$export_dir"

echo -e "${BOLD}${YELLOW}Clear exports? ${RED}$clear_exports${RESET}"
# Clear downloaded files, or reinstate extracted results
if [[ "$clear_exports" == "true" && "$dry_run" != "true" ]]; then
	sleep 2
    echo -e "${FIRE}${FIRE}${RED}${BOLD} clear_exports is set to 'true'. Removing the zip file & any extracted directories ${FIRE}${FIRE}${RESET}"

    # Remove the directory and all its contents
    if [[ -d "$export_dir" ]]; then
        echo -e "${BOLD}${EXPLOSION}${EXPLOSION}${RED} Removing directory:${RESET} $export_dir ${EXPLOSION}${EXPLOSION}${RESET}"
        rm -rf "$export_dir"
    else
        echo -e "${BOLD}Directory not found:${RESET} $export_dir"
    fi

    # Remove the zip file
    if ls *"$zip_extension" >/dev/null 2>&1; then
        echo -e "${BOLD}${EXPLOSION}${EXPLOSION}Removing zip file:${RESET} $zip_extension ${EXPLOSION}${EXPLOSION}${RESET}"
        rm -f *"$zip_extension"
    else
        echo -e "${BOLD}Zip file not found:${RESET} $zip_extension"
    fi

else
	echo -e ${BOLD}${YELLOW}"Not today, friend, not today...${RESET}"
fi

echo -e "${STAR}${STAR}${STAR}${GREEN}${BOLD} Splines reticulated ${STAR}${STAR}${STAR}${RESET}"
echo ""