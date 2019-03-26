#!/usr/bin/env bash

function m2_maintenance_enable () {
    cd "$deploy_path/$release" && 
        php -d memory_limit=-1 bin/magento maintenance:enable
}

function m2_maintenance_disable () {
    cd "$deploy_path/$release" && 
        php -d memory_limit=-1 bin/magento maintenance:disable
}

function m2_cache_clean () {
    cd "$deploy_path/$release" && 
        php bin/magento cache:clean
}