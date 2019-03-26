# Magento 2 deploy shell script

>**Author:** Maks Proshkin mxs34@quartsoft.com

## Installing and usage  
    1. git clone git@gitlab.quartsoft.com:mxs/m2_shell_deploy.git <dir>
    2. cd <dir>
    3. bash deploy.sh [<path_to_config>]
## Example of config file YML

        repository: <repository>
        branch: <branch>
        deploy_path: <path_to_your_project>
        languages: ru_RU en_US
        default_language: en_US
        base_url: <project_url>
        backend_url: admin
        deploy_mode: default | developer | production
        default_admin: 
            name: admin
            password: *******
            email: email@example.com
        db:
            host: localhost
            dbname:   ***
            username: ***
            password: ***


