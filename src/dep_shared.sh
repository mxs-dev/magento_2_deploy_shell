#!/usr/bin/env bash

declare -a shared_dirs=(
    "pub/media"
    "var/log"
);
declare -a shared_files=("app/etc/env.php");

function dep_shared () {
    local shared_path="${deploy_path}/${shared_dir}";
    
    # Creating shared folders
    for dir in ${shared_dirs[*]}
    do  
        mkdir -p "$shared_path/$dir"
        if [[ -d "$deploy_path/$release/$dir" ]]; then
            cp -rv "$deploy_path/$release/$dir/." "$shared_path/$dir"           
        fi

        rm -rf "$deploy_path/$release/$dir"
        ln -s  "$shared_path/$dir" "$deploy_path/$release/$dir"
    done    

    # Creating shared files
    for file in ${shared_files[*]}
    do 
        if [[ -f "$deploy_path/$release/$file" ]]; then
            cp -rv "$deploy_path/$release/$file" "$shared_path/$file"
        else
            local dir=$(dirname $file)
            mkdir -p "$shared_path/$dir"
            touch "$shared_path/$file"
        fi

        ln -s "$shared_path/$file"  "$deploy_path/$release/$file"
    done
}