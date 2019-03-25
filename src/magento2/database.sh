#!/usr/bin/env bash

exceptions["200"]="Error: mysql is down. Please start and try later.";
exceptions["201"]="Error: db(host, dbname, username, password) are required fields.";

function m2_db_create () {    
    if [[ -z $db_host || -z $db_dbname || -z $db_username || -z $db_password ]]; then 
        throw 201;
    fi

    local query="CREATE DATABASE IF NOT EXISTS ${db_dbname};"
    local up=$(pgrep mysql | wc -l);
    if [ $up -lt 0 ]; then
        throw 200;
    else 
        printf "Creating a database ${db_dbname}\n";
        echo $(mysql -h${db_host} -u${db_username} -p${db_password} -e "${query}");
    fi
}

function m2_db_upgrade () {
    echo $(cd $current_release && php -d memory_limit=-1 bin/magento setup:upgrade --keep-generated);
}