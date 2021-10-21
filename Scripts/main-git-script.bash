#!/bin/bash

. /home/merkle-filipe/source/repos/gitconfig/Scripts/basic-git-operations.bash
. /home/merkle-filipe/source/repos/gitconfig/Scripts/create-pull-request.bash

# Execute the flow
main() { 
    read -p "What is the name of the main branch? " MAIN_BRANCH
    git status
    if [ $? -eq 0 ];
    then
        # Resume the flow
        ACTIVE_BRANCH=`git status | awk '{print $3}' | awk 'FNR == 1'`
        # Execute basic_git_operations
        basic_git_operations
        # Use the name of the branch
        if [[ "$ACTIVE_BRANCH" != "$MAIN_BRANCH" ]];
        then
        # if they don't match, do a checkout to main branch, perform pull, merge previous branch into main branch
            git checkout $MAIN_BRANCH
            git pull
	        git checkout $ACTIVE_BRANCH
            git merge $MAIN_BRANCH
            basic_git_operations
	        create_pull_request "$MAIN_BRANCH" "$ACTIVE_BRANCH"
            exit 0
        else 
        # else, everything is ok
            exit 0
        fi
    else
        echo "You've got no changes!"
        exit 1
    fi
}

main
