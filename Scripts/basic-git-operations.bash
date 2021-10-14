#!/bin/bash

. <replace-by-full-filepath-to>/select-files-to-add.bash

# Sync and push the changes to the repository
basic_git_operations() {
    git pull

    if [ $? -ne 0 ];
    then
        echo "You are not in the proper directory"
    else
        read -p "Do you want to commit and push your changes (y/n)? " ANSWER
        if [ $ANSWER == 'y' ] || [ $ANSWER == 'Y' ];
        then
            select_files_to_add
            read -p "What's the message you desire to type? " MESSAGE
            git commit -m "$MESSAGE"
            read -p "What's the name of the current active branch? " MYBRANCH
            read -p "What's the name of the destination branch? " REPOBRANCH
            git push -u $REPOBRANCH $MYBRANCH
        else
            echo "Hope to see you again!"
        fi
    fi
}
