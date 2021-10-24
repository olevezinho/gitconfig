#!/bin/bash

. ~/Documents/source/repos/basic-git-operations.bash

# Execute the flow
main() {
    # authenticate against github api
    gh auth login
    
    # read name of the default branch
    MAIN_BRANCH=`git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'` # or git rev-parse --abbrev-ref origin/HEAD
    
    git status
    if [ $? -eq 0 ];
    then
        # Resume the flow
        ACTIVE_BRANCH=`git status | awk '{print $3}' | awk 'FNR == 1'` # or git rev-parse --abbrev-ref HEAD
        # Use the name of the branch
        if [[ "$ACTIVE_BRANCH" != "$MAIN_BRANCH" ]];
        then
        # If the branch names don't match, push changes. Then do a checkout to main branch, perform pull. 
        # After that, checkout to previous branch, and merge main branch into current branch
            read -p "Do you want to commit and push your changes (y/n)? " ANSWER
            if [ $ANSWER == 'y' ];
            then
                echo "You're about to push your changes"
                git add .
                read -p "What's the message you desire to type? " MESSAGE
                git commit -m "$MESSAGE"
                git push -u origin $ACTIVE_BRANCH
            else
                    echo "Hope to see you again!"
            fi
            Flag='false'
            git checkout $MAIN_BRANCH
            git pull
            git checkout $ACTIVE_BRANCH
            git merge $MAIN_BRANCH
            basic_git_operations $Flag $ACTIVE_BRANCH
            exit 0
        else
        # else, everything is ok
            Flag='true'
            basic_git_operations $Flag $MAIN_BRANCH
            exit 0
        fi
    else
        echo "You've got no changes!"
        exit 1
    fi
}

main
