#!/usr/bin/env bash

exceptions["200"]="Error: mysql is down. Please start and try later.";
exceptions["201"]="Error: db(host, dbname, username, password) are required fields.";

function m2_db_create () {

    if [[ -z $db_host || -z $db_dbname || -z $db_username || -z $db_password ]]; then 
        throw 201;
    fi

    local query="CREATE DATABASE IF NOT EXISTS ${db_dbname};"
    
    if [ pgrep mysql | wc -l | -lt 0 ]; then
        throw 200;
    else 
        echo $(mysql -h${db_host} -u${db_username} -p${db_password} -e "${query}");
    fi
}