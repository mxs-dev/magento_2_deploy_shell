#!/usr/bin/env bash

function getReleaseName () {
    cd "$deploy_path/$releases_dir" &&
    echo $(ls -l | grep ^d | wc -l);
}

function dep_release () {
    current_release="$deploy_path/$releases_dir/$(getReleaseName)"
    
    # Making directory for new release
    mkdir $current_release

    #Removing old release-symlink if exists
    if [[ -L "$deploy_path/release" ]]; then 
        rm "$deploy_path/release";
    fi
    
    # Making symbolic link for current release
    ln -s  $current_release "$deploy_path/release"
}