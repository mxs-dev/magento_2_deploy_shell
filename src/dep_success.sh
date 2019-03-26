#!/usr/bin/env bash

function dep_success () {
    local current_release = $(cd "$deploy_path/release" && realpath . ); 

    #Removing temporary release-symlink
    if [[ -L "$deploy_path/$release" ]]; then 
        rm "$deploy_path/$release";
    fi

    #Removing old current release-symlink if exists
    if [[ -L "$deploy_path/$current" ]]; then 
        rm "$deploy_path/$current";
    fi

    # Making symbolic link for current release
    ln -s  $current_release "$deploy_path/$current"
}