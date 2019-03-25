#!/usr/bin/env bash

declare -a writable_dirs=(
    "pub/static"
    "pub/media"
);
declare -r permissions="0777";

function dep_writable () {
    printf "Running: dep_writable.\n";

    cd $current_release 

    # Processing Magneto2 Installation Guide commands
    find var generated vendor pub/static pub/media app/etc -type f -exec chmod u+w {} +
    find var generated vendor pub/static pub/media app/etc -type d -exec chmod u+w {} +
    chmod u+x bin/magento

    # Setting write permissions to 
    for dir in ${writable_dirs[*]}
    do 
        chmod -R $permissions $dir
    done
}