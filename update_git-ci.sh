#!/bin/bash

USER_HOME="$(env|grep ^HOME=|cut -c 6-)"

COMAND_PATHS=("/usr/local/bin" "$USER_HOME/bin" "/mingw64/bin")
PATH_NUM=0
uname -a|egrep -i linux && { echo $PATH|egrep /usr/local/sbin || PATH=$PATH:/usr/local/sbin ; }
for p in "${COMAND_PATHS[@]}" ; do
    if [[ "$(echo $PATH | grep "${p}")" ]]; then
        touch "$p/git-toolkit-temp" > /dev/null 2>&1
        if [[ $? == 0 ]]; then
            COMMAND_PATH_PREFIX="$p"
            rm "$p/git-toolkit-temp" > /dev/null 2>&1
            break;
        fi
    fi
    PATH_NUM=$(($PATH_NUM+1))
done
if [[ $PATH_NUM =~ ^[0-$(expr ${#COMAND_PATHS[@]} - 1)] ]]; then
    COMAND_PATH=${COMAND_PATHS[PATH_NUM]}
fi
REPO_NAME="git-ci"

INSTALL_PATH="$COMAND_PATH/$REPO_NAME"




echo $INSTALL_PATH
sed -i 's/\-a//' $INSTALL_PATH
