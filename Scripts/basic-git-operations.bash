#!/bin/bash

# Sync and push the changes to the repository
basic_git_operations() {
    # pull changes before committing them
    git pull
    # evaluate return status of last command
    if [ $? -ne 0 ];
    then
       echo "You are not in the proper directory"
    else
        read -p "Do you want to commit and push your changes (y/n)? " ANSWER
        if [ $ANSWER == 'y' ];
        then
            echo "You're about to push your changes"
            git add .
            read -p "What's the message you desire to type? " MESSAGE
            git commit -m "$MESSAGE"
            git push -u origin $1
        else
            echo "Hope to see you again!"
        fi
    fi
}
