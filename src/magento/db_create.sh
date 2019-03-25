#!/usr/bin/env bash

function db_create () {
    local query="CREATE DATABASE IF NOT EXISTS ${db_dbname};"
    
    local UP=$(pgrep mysql | wc -l);
    if [ "$UP" -lt 0 ]; then
        echo "MySQL is down.";
        exit 1;
    else 
        echo $(mysql -h${db_host} -u${db_username} -p${db_password} -e "${query}");
    fi
}