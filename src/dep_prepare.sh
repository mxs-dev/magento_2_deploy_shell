#!/usr/bin/env bash
# shellcheck disable=SC1003

shared_dir='shared'
releases_dir='releases'

# $deploy_path - global variable from config
function dep_prepare() {    
    if [[ ! -d $deploy_path ]]; then 
        mkdir -p $deploy_path
    fi

    cd $deploy_path && 
    if [[ ! -d $shared_dir ]]; then 
        mkdir $shared_dir
    fi

    cd $deploy_path && 
    if [[ ! -d $releases_dir ]]; then 
        mkdir $releases_dir
    fi
}