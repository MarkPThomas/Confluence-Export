#!/bin/bash

# Copies fresh staging directories to specified location
# It also records installation info to a config file

# Get the full directory where the script is located
script_path="$(cd "$(dirname "$0")" && pwd)"

# Read config file, if it exists

# Variables to change for each different Confluence space
staging_path=""

# default? = users/Downloads
# TODO: Set staging_path with (optional?) argument

# Optional overwrite
staging_dir="ConfluenceWiki"

# Optional overwrite
staging_wiki_dir="wiki"

# Optional value to be overwritten later
# This is the name of the extracted directory that comes out of the downloaded .zip and MUST be present!
# User should be prompted to give this, and if not,
#	told that it must be manually updated in the created config file before running scripts
extract_dir=""

# set staging_wiki_dir=site_wiki_dir if site_wiki_dir specified in config
# set staging_wiki_dir to optional argument
# Copy _staging to staging_path/staging_dir & rename it to staging_wiki_dir
# if path already exists, just copy & rename _staging to path

# Move config file to staging

# Create/modify config file in _assets w/ settings:
#	staging_path
#	staging_dir
#	staging_wiki_dir