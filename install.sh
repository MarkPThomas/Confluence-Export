#!/bin/bash

# This runs both installation files sequentially in the correct order
# If you only want to install one, run that script directly

# Get the full directory where the script is located
script_path="$(cd "$(dirname "$0")" && pwd)"

bash "$script_path/install-site.sh"
bash "$script_path/install-staging.sh"