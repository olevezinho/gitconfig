#!/bin/bash

# Sync and push the changes to the repository
basic_git_operations() {
    # pull changes before committing them
    if [ $1 == 'true' ];
    then
        git pull
    fi
    
    read -p "Do you want to commit and push your changes (y/n)? " ANSWER
    if [ $ANSWER == 'y' ];
    then
        echo "You're about to push your changes"
        git add .
        read -p "What's the message you desire to type? " MESSAGE
        git commit -m "$MESSAGE"
        git push -u origin $2
    else
        echo "Hope to see you again!"
    fi
}
