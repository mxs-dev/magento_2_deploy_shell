#!/usr/bin/env bash

function dep_vendors () {
    cd $current_release &&
        composer install
}