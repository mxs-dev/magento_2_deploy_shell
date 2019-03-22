#!/usr/bin/env bash

function db_create () {
    local query="CREATE DATABASE IF NOT EXISTS '{$db_dbname}';"
    
    mysql -h$db_host -u$db_username -p$db_password -e $query;
}