#!/usr/bin/env bash

exceptions["150"]="Error: composer install - failed."

function dep_vendors () {
    cd $current_release &&
        composer install --no-dev

    if [[ $? -ne 0 ]]; then
        throw 150;
    fi;
}