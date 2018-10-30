#!/bin/bash

merger_branch=$1
mergee_branch=$2
##定义merge使用的驱动
drivers=ours

function permission()
{
echo "这个脚本将清理本地未提交的保存，确定(输入1/2)?"
select yn in "Yes" "No"; do
    case $yn in
        Yes) break;;
        No) exit;;
    esac
done
}

function prepare_mergee_branch()
{
    branch_name=$1
    driver=$2

    current_branch=`git branch  | grep \* | awk '{print $2}'`

    git fetch
    git checkout $branch_name
    git pull origin $branch_name

    static_path=gameserver/application/lib/static/zh-Hans
    activity_path=gameserver/application/lib/activity/zh-Hans

    attributes_file='attribute_tmp_file'
    rm $attributes_file -rf 2>/dev/null
    rm ../../.gitattributes -rf 2>/dev/null

    for filename in `ls ../application/lib/static/zh-Hans/  -la | awk '{print $9}'`
    do
        echo $static_path/$filename  merge=$driver >> $attributes_file
    done

    for filename in `ls ../application/lib/activity/zh-Hans/ -la | awk '{print $9}'`
    do
        echo $activity_path/$filename merge=$driver >> $attributes_file
    done

    echo gameserver/data/branchTableSuffix.php merge=$driver >> $attributes_file

    echo 'create attribute config file successfully.'

    mv $attributes_file ../../.gitattributes
    ls -la ../../.gitattributes
    git add  "../../.gitattributes"
    git commit "../../.gitattributes" -m "设置合并忽略文件"
    git push origin $branch_name
    git checkout $current_branch
}

function clear_mergee_branch()
{
     branch_name=$1

     current_branch=`git branch  | grep \* | awk '{print $2}'`

    git fetch
    git checkout $branch_name
    git pull origin $branch_name

     rm ../../.gitattributes -rf > /dev/null
     git rm "../../.gitattributes" > /dev/null
     git commit -m "删除合并忽略文件" > /dev/null
     git push origin $branch_name > /dev/null

     git checkout $current_branch
}

# 成功
function success()
{
    echo -e "\033[32m 合并成功 \033[0m"
}

# 错误输出
function error_output()
{
    text=$1
    echo -e "\033[31m $text \033[0m"
}

function start()
{
    git config --global merge.$drivers.driver true
    git config --global core.filemode false
}

function clear()
{
    git config --global --unset core.filemode
    git config --global --unset merge.$drivers.driver
}

function action()
{
    merger=$1
    mergee=$2
    current_branch=`git branch  | grep \* | awk '{print $2}'`
    git reset HEAD --hard >> /dev/null &&
    git fetch >> /dev/null &&
    prepare_mergee_branch  $mergee $drivers &&
    git checkout $merger >> /dev/null &&
    git pull origin $merger >> /dev/null &&
    echo 'start merging ...' &&
    git config --global --list &&
    git merge $mergee &&
    echo 'end of  merging.'

    if [ $? -ne 0 ]; then
        error_output 'merge failed, exiting ...'
        echo "recovering from merge scene ..."
        git reset HEAD --hard >> /dev/null 2>&1
        git checkout $current_branch >> /dev/null 2>&1
        clear
        clear_mergee_branch $mergee
        exit
    fi

    echo "recovering from merge scene ..."
    git reset HEAD --hard
    git checkout $current_branch

    clear
    clear_mergee_branch $mergee
    success
}

# 检测输入
function check()
{
    src_name=$1
    dest_name=$2
    if [ "$src_name" == "" ]; then
       echo source_name can not be empty, exiting...
       exit
    fi

    if [ "$dest_name" == "" ]; then
       echo destination_name can not be empty, exiting...
       exit
    fi
}

check $merger_branch $mergee_branch
permission
start
action $merger_branch $mergee_branch
