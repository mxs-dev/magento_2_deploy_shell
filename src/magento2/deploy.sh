#!/usr/bin/env bash

function m2_deploy_mode_set () {
    if [[ -z $deploy_mode ]]; then 
        echo $(php bin/magento deploy:mode:set --skip-compilation);
    fi
}

function m2_deploy_assets () {
    local languages_string="";

    if [[ ! -z $languages && -z $default_language ]]; then 
        printf "Using default_language for static-content:deploying\n";
        $languages=($default_language);
    else 
    if [[ ! -z $languages &&  ! -z $default_language ]]; then
        printf "Using en_US for static-content:deploying\n";
        $languages=('en_US');
    fi  

    for lang in ${languages[*]} do 
        languages_string+=" ${lang}";
    done
    
    echo $(php -d memory_limit=-1 bin/magento setup:static-content:deploy ${langs});
}