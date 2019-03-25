#!/usr/bin/env bash

exceptions["210"]="Error: base_url and backend_url is required fields.";
exceptions["211"]="Error: db(host, dbname, username, password) are required fields.";
exceptions["212"]="Error: default_admin(name, password, email) are required fields.";
exceptions["213"]="Error: Your installation has env.php file, but selected database is clear.";
exceptions["214"]="Error: Magento 2 setup:install command failed.";
exceptions["250"]="Error: Magento 2 setup:di:compule command failed.";

function isDatabaseClear () {
    local query="SELECT COUNT(*) FROM information_schema.TABLES WHERE (table_schema = \"${db_dbname}\");";
    local tables_count=$(mysql -h$db_host -u$db_username -p$db_password  -s -N -e "$query");

    echo $([ $tables_count -le 0 ]);
}

function m2_install () {
    if [[ -z $base_url || -z $backend_url ]]; then
        throw 210;
    fi

    if [[ -z $db_host || -z $db_dbname || -z $db_username || -z $db_password ]]; then 
        throw 211;
    fi

    if [[ -z $default_admin_name || -z $default_admin_password || -z $default_admin_email ]]; then
        throw 212;
    fi

    local command="php -d memory_limit=-1 bin/magento setup:install";
    command+=" --db-host=${db_host}";
    command+=" --db-name=${db_dbname}";
    command+=" --db-user=${db_username}";
    command+=" --db-password=${db_password}";

    command+=" --base-url=${base_url}";
    command+=" --backend-frontname=${backend_url}";

    command+=" --admin-user=${default_admin_name}";
    command+=" --admin-firstname=${default_admin_name}";
    command+=" --admin-lastname=${default_admin_name}";
    command+=" --admin-email=${default_admin_email}";
    command+=" --admin-password=${default_admin_password}";

    command+=" --use-rewrites=1";

    if [[ ! -z $db_prefix ]]; then 
        command+=" --db-prefix=${db_prefix}";
    fi

    if [[ ! -z $default_language ]]; then   
        command+=" --language=${default_language}";
    else
        command+=" --language=en_US";
    fi

    local isDBClear=$(isDatabaseClear);
    local isEnvFileExists=$(test -s "$current_release/app/etc/env.php");

    if [[ !$isEnvFileExists && !$isDBClear ]]; then
        printf "Selected database is not clear.\n";
        read -p "Do you want to run DB cleanup during the Magento 2 installation (y/n) ?  " run_cleanup
        
        if [[ "$run_cleanup" = 'y' || "$run_cleanup" = 'Y' ]]; then
            printf "Installing Magento 2 with cleanup... \n";
            command+=" --cleanup-database";
        fi
    elif [[ $isEnvFileExists && $isDBClear ]]; then
        throw 213;
    else 
        printf "Skipped -> Magento 2 is already installed.\n";
        return 0;
    fi

    # Temporary removing link to env.php
    rm -f "$release_path/app/etc/env.php";

    cd $release_path && $command;
    if [[ $? -ne 0 ]]; then
        throw 214;
    fi;

    # Copying env.php file to shared folder and re-creating symlink to it.
    mv "$release_path/app/etc/env.php" "$shared_path/app/etc/evn.php";
    ln -s "$shared_path/app/etc/evn.php" "$release_path/app/etc/env.php";
}

function m2_di_compile () {
    cd $release_path &&
        php -d memory_limit=-1 bin/magento setup:di:compile;
    
    if [[ $? -ne 0 ]]; then
        throw 250;
    fi;
}