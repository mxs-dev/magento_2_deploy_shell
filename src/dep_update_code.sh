#!/usr/bin/env bash

exceptions["130"]="Error: git clone - failed.";

function dep_update_code () {    
    cd $current_release
    git clone $repository -b $branch .

    if [[ $? -ne 0 ]]; then 
        throw 130;
    fi;
}