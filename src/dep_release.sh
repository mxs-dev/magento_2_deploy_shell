#!/usr/bin/env bash

declare -r DEFAULT_RELEASES_COUNT=3;

exceptions["110"]="Error: fetching last commit id from git failed";

function getReleaseName () {
    local var=$(git ls-remote ${repository} refs/heads/${branch} | awk '{ print $1 }');

    if [[ $? -ne 0 ]]; then 
        throw 110;
    fi;

    echo ${var};
}

function deleteElderReleases () {
    if [[ -z $releases_count ]]; then 
        releases_count=$DEFAULT_RELEASES_COUNT;
    elif [[ $releases_count -eq "-1" ]]; then
        # Releases count -1 is not limited releases.
        return 0;
    fi

    cd "$deploy_path/$releases_dir";

    # Getting list of all directories sorted by date ASC
    local releases=( $(ls -t -r .) );
    local count=${#releases[@]};
    
    # Deleting old releases
    if [[ $count -gt $releases_count ]]; then 
        local count_to_delete=$(expr $count - $releases_count);
        for dir in ${releases[*]:0:$count_to_delete}
        do  
            rm -rf $dir;
        done
    fi
}

function dep_release () {
    local current_release="$deploy_path/$releases_dir/$(getReleaseName)";
    
    # Making directory if it is a new release
    if [[ ! -d $current_release ]]; then 
        mkdir $current_release
    fi

    # Removing old temporary release-symlink if exists
    if [[ -L "$deploy_path/$release" ]]; then 
        rm "$deploy_path/$release";
    fi
    
    # Making temporary symbolic link for current release
    ln -s  $current_release "$deploy_path/$release"

    # Cleaning old releases
    deleteElderReleases
}