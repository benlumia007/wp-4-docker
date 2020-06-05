#!/usr/bin/env bash

config=".global/docker-custom.yml"

get_resources() {
    local value=`cat ${config} | shyaml get-value resources`
    echo ${value:$@}
}

repo="https://github.com/benlumia007/docker-for-wordpress-resources.git"
dir="scripts/resources"

resources=`get_resources`

for name in ${resources//- /$'\n'}; do
    if [[ false != ${name} && false != ${repo} ]]; then
        if [[ ! -d ${dir}/.git ]]; then
            git clone ${repo} ${dir} -q
        else
            cd ${dir}
            git pull origin master -q
            cd ../..
        fi
    fi

    source ${dir}/${name}/setup.sh
done