#!/usr/bin/env bash

function getReleaseName () {
    cd "$deploy_path/$releases_dir" &&
        echo $(ls -l | grep ^d | wc -l);
}

function dep_release () {
    local release_name=$(getReleaseName)
    current_release="$deploy_path/$releases_dir/$release_name"
    
    # Making directory for new release
    mkdir $current_release

    # Making symbolic link for current release
    ln -s  $current_release "$deploy_path/release"
}