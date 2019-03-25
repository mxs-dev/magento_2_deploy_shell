#!/usr/bin/env bash

function dep_vendors () {
    printf "Running: dep_vendors.\n";    
    local res=$(cd $current_release && composer install);
}