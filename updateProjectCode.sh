#!/bin/bash
# Creat by guanhua.guo.hz
# Update Project Code and auto-make
# exit(0)

project_path="/home/swd3/workspace"
project_list=(pixi4553g pixi454g elsa6 buzz6t4g)
#project_list=(buzz6t4g)
repo_path="/home/swd3/software/repo"

#begin
echo "-------------------------------"
date
echo "-------------------------------"

function updateProjectCode()
{
    for project in ${project_list[@]}
    do
        project_name=${project_path}/${project}/v1.0-dint
        echo "-------------------------------"
        if [ ! -d "${project_name}" ]; then
            mkdir -p ${project_name}
            echo "${project_name} is not exist, creat it."
        fi
        cd ${project_name}
        if [ ! -d ".repo" ]; then
            if [ "${project}" = "buzz6t4g" ]; then
                echo "y" | ${repo_path}/repo init -u git@10.92.32.10:sdd3/manifest -m buzz6t-4g-v1.0-dint.xml
            elif [ "${project}" = "elsa6" ]; then
                echo "y" | ${repo_path}/repo init -u git@10.92.32.10:sdd3/manifest -m elsa6-v1.0-dint.xml
            elif [ "${project}" = "pixi454g" ]; then
                echo "y" | ${repo_path}/repo init -u git@10.92.32.10:sdd3/manifest -m pixi4-5-4g-v1.0-dint.xml
            elif [ "${project}" = "pixi4553g" ]; then
                echo "y" | ${repo_path}/repo init -u git@10.92.32.10:sdd3/manifest -m pixi4-55-3g-shine-3g-v1.0-dint.xml
            else
                echo "Have no manifest for ${project}!"
                continue
            fi
            echo "${repo_path}/repo sync"
            ${repo_path}/repo sync -j12
        else
            echo "${repo_path}/repo reset&sync"
            ${repo_path}/repo forall -c "git reset --hard HEAD"
            ${repo_path}/repo sync -j12
        fi
        echo "${project} is OK!"
    done
}

function newProjectMake()
{
    for project in ${project_list[@]}
    do
        project_name=${project_path}/${project}/v1.0-dint
        if [ -d "${project}" ]; then
            rm -rf ${project}
            echo "rm -rf ${project}"
        fi
    done
}

function delete()
{
    for project in ${project_list[@]}
    do
        project_name=${project_path}/${project}/v1.0-dint
        if [ -d "${project}" ]; then
            rm -rf ${project}
            echo "rm -rf ${project}"
        fi
    done
}

updateProjectCode
if [ $# != 0 ] ; then
    if [ $1 = "make" ] ; then
        if [ $# = 1 ] ; then
            echo "nico make" 
        elif [ $1 = "make" ] ; then
            #newProjectMake
            echo "nico make"
        fi
    fi
fi

echo "-------------------------------"
date
echo "-------------------------------"
