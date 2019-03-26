#!/usr/bin/env bash

exceptions["260"]="Error: Magento 2 setup:deploy-mode:set failed";
exceptions["270"]="Error: Magento 2 setup:static-content:deploy failed";

function m2_deploy_mode_set () {
    cd "$deploy_path/$release";

    if [[ ! -z $deploy_mode ]]; then 
        php bin/magento deploy:mode:set $deploy_mode --skip-compilation;
        if [[ $? -ne 0 ]]; then
            throw 260;
        fi;
    fi
}

function m2_deploy_assets () {  
    local languages_string="";
    local flag="";

    if [[ -z $languages && ! -z $default_language ]]; then 
        printf "Using default_language for static-content:deploying\n";
        languages=("${default_language}");
    elif [[ -z $languages &&  -z $default_language ]]; then
        printf "Using en_US for static-content:deploying\n";
        languages=("en_US");
    fi  

    if [[ $deploy_mode != 'production' ]]; then 
        flag="-f";
    fi
    
    for lang in ${languages[*]}; do 
        languages_string+=" $lang";
    done

    cd "$deploy_path/$release" && 
        php -d memory_limit=-1 bin/magento setup:static-content:deploy ${flag} ${languages_string}

    if [[ $? -ne 0 ]]; then
        throw 270;
    fi;
}