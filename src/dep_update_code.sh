#!/usr/bin/env bash

exceptions["130"]="Error: sode updating - failed.";

function dep_update_code () {    
    cd "$deploy_path/$release";

    if [[ -z $branch ]]; then
        branch="master";
    fi

    if [[ -d .git ]]; then 
        git fetch --all
        git reset --hard origin/$branch
        git pull origin $branch
    else 
        git clone --depth=1 $repository -b $branch .
    fi;

    if [[ $? -ne 0 ]]; then 
        throw 130;
    fi;
}