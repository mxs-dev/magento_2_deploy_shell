#!/usr/bin/env bash

function m2_maintenance_enable () {
    echo $(php -d memory_limit=-1 bin/magento maintenance:enable)
}

function m2_maintenance_disable () {
    echo $(php -d memory_limit=-1 bin/magento maintenance:disable)
}

function m2_cache_clean () {
    echo $(php bin/magento cache:clean);
}