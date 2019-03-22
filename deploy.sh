#!/usr/bin/env bash
# shellcheck disable=SC2154
# shellcheck disable=SC1091
set -e
home_dir=$PWD

# Reading configuration
source "$home_dir/src/parse_yaml.sh"
create_variables ./config.yml

# Prepairing host for deploy
source "$home_dir/src/dep_prepare.sh"
dep_prepare

# Creating a folder for new release
source "$home_dir/src/dep_release.sh"
dep_release 

# Downloading code for new release
source "$home_dir/src/dep_update_code.sh"
dep_update_code

# Creating shared folders
source "$home_dir/src/dep_shared.sh"
dep_shared

# Calling composer install method
source "$home_dir/src/dep_vendors.sh"
dep_vendors