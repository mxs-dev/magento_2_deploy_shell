#!/usr/bin/env bash

clear_path=("var/generation/*" "var/cache/*")

function clear_path () {
    printf "Running: dep_clear_path.\n";    
    # Cleaing paths
    for dir in ${clear_path[*]}
    do 
        rm -rf $dir
    done
}