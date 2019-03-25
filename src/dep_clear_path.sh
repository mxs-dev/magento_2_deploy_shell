#!/usr/bin/env bash

declare -a clear_path=("var/generation/*" "var/cache/*")

function dep_clear_path () {
    # Cleaing paths
    for dir in ${clear_path[*]}
    do 
        rm -rf $dir
    done
}