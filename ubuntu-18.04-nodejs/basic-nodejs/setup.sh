#!/bin/bash

# Just delegate down
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#The pushd command saves the current working directory in memory so it can be returned to at any time
pushd "$SCRIPT_DIR" > /dev/null

# Init submodules
git submodule init
git submodule update

# Get some color codes for printing
source common-setup/bash.d/colors

echo -e $(blue "Installing common setup")
common-setup/setup.sh


# Restore current directory of user
popd > /dev/null

# Re-read BASH settings
green "\n\nRemember to 'source ~/.bashrc or source ~/.zshrc'!"