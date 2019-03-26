#!/usr/bin/env bash

declare -a shared_dirs=(
    "pub/media"
    "var/log"
);
declare -a shared_files=("app/etc/env.php");

function dep_shared () {
    local shared_path="${deploy_path}/${shared_dir}";
    local current_release=$(cd "$deploy_path/$release" && realpath . ); 

    # Creating shared folders
    for dir in ${shared_dirs[*]}
    do  
        mkdir -p "$shared_path/$dir"
        if [[ -d "$current_release/$dir" ]]; then
            cp -rv "$current_release/$dir/." "$shared_path/$dir"           
        fi

        rm -rf "$current_release/$dir"
        ln -sf  "$shared_path/$dir" "$current_release/$dir"
    done    

    # Creating shared files
    for file in ${shared_files[*]}
    do 
        if [[ -f "$current_release/$file" ]]; then
            cp -rv "$current_release/$file" "$shared_path/$file"
        else
            local dir=$(dirname $file)
            mkdir -p "$shared_path/$dir"
            touch "$shared_path/$file"
        fi

        ln -sf "$shared_path/$file" "$current_release/$file"
    done
}