#!/bin/bash

function try()
{
    [[ $- = *e* ]]; SAVED_OPT_E=$?
    set +e
}
function throw()
{
    exit $1
}
function catch()
{
    export ex_code=$?
    (( $SAVED_OPT_E )) && set +e
    return $ex_code
}
function throwErrors()
{
    set -e
}
function ignoreErrors()
{
    set +e
}

declare -r RED="\033[0;31m";
declare -r BG_RED="\033[41m";
declare -r GREEN="\033[0;32m";
declare -r BG_GREEN="\033[42m";

function printError() {
    printf "${BG_RED}\n$1\n\n\033[0m";
}

function printSuccess() {
    printf "${BG_GREEN}\n$1\n\n\033[0m";
}