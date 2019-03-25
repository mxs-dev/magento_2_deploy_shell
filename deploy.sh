#!/usr/bin/env bash
declare -r home_dir=$PWD;
declare -A exceptions

source "$home_dir/src/functions.sh"
source "$home_dir/src/parse_yaml.sh"

source "$home_dir/src/dep_prepare.sh"
source "$home_dir/src/dep_release.sh"
source "$home_dir/src/dep_update_code.sh"
source "$home_dir/src/dep_shared.sh"
source "$home_dir/src/dep_vendors.sh"
source "$home_dir/src/dep_writable.sh"
source "$home_dir/src/dep_clear_path.sh"

source "$home_dir/src/magento2/db_create.sh"
source "$home_dir/src/magento2/install.sh"

# Reading configuration
create_variables ./config.yml

declare -a tasks=(
    # "dep_prepare"       # Prepairing host for deploy
    # "dep_release"       # Creating a folder for new release
    # "dep_update_code"   # Downloading code for new release
    # "dep_shared"        # Creating shared folders
    # "dep_vendors"       # Calling composer install method
    # "dep_writable"      # Setting permissions to files and folders
    # "dep_clear_path"    # Clearing paths

    # "m2_db_create"
    "m2_install"
);

try
(
    for task in ${tasks[*]}; do  
        ${task}
    done
) 
catch || {
    printError "${exceptions[$ex_code]}"
}