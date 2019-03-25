#!/usr/bin/env bash
declare -r home_dir=$PWD;
declare -A exceptions;

source "$home_dir/src/functions.sh"
source "$home_dir/src/parse_yaml.sh"

source "$home_dir/src/dep_prepare.sh"
source "$home_dir/src/dep_release.sh"
source "$home_dir/src/dep_update_code.sh"
source "$home_dir/src/dep_shared.sh"
source "$home_dir/src/dep_vendors.sh"
source "$home_dir/src/dep_writable.sh"
source "$home_dir/src/dep_clear_path.sh"

source "$home_dir/src/magento2/database.sh"
source "$home_dir/src/magento2/setup.sh"
source "$home_dir/src/magento2/maintenance.sh"
source "$home_dir/src/magento2/deploy.sh"


# Reading configuration
create_variables ./config.yml

# Variables for debugging m2_* scripts.
declare release_path="$deploy_path/release";
declare current_release="$deploy_path/release";
declare shared_path="$deploy_path/shared";

declare -a tasks=(
    # "dep_prepare"       # Prepairing host for deploy
    # "dep_release"       # Creating a folder for new release
    # "dep_update_code"   # Downloading code for new release
    # "dep_shared"        # Creating shared folders
    # "dep_vendors"       # Calling composer install method
    # "dep_writable"      # Setting permissions to files and folders
    # "dep_clear_path"    # Clearing paths

    "m2_db_create"          # Creating database if it doesn`t exists
    "m2_install"            # Installing Magento 2 application
    "m2_maintenance_enable" 
    "m2_db_upgrade"
    "m2_di_compile"
    "m2_maintenance_disable"
    "m2_deploy_mode_set"
    "m2_deploy_assets"
    "m2_cache_clean"
    "m2_maintenance_disable"
);

try
(
    for task in ${tasks[*]}; do
        logTask "${task}";
        ${task}
    done
) 
catch || {
    printError "${exceptions[$ex_code]}"
    exit 1;
}

printSuccess "Deploying is finished";