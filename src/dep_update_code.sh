#!/usr/bin/env bash

function dep_update_code () {
    cd $current_release &&
    git clone $repository -b $branch .
}