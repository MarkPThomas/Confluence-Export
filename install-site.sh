#!/bin/bash

# This installs components to the specifed site, and creates a directory for the site if necessary
# It also records installation info to a config file

# Get the full directory where the script is located
script_path="$(cd "$(dirname "$0")" && pwd)"

# Variables to change for each different Confluence space
site_path="/Users/markthomas/coding/MarkPThomas.github.io/"
site_wiki_dir="wiki"

# TODO: Set site_path with argument
# Override site_wiki_dir with optional argument if provided

# Taken as last dir in site_wiki_dir unless specified
site_dir=""

# If flag designates it w/ site_dir, copy _website to site_path and rename it to site_dir
#   else, copy assets & wiki to site_path
# In both cases, rename 'wiki' to site_wiki_dir if different


# Create/modify config file in _assets w/ settings:
#	site_path 
#	site_dir
#	site_wiki_dir
