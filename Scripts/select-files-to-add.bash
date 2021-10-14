#!/bin/bash
# Select the files to be pushed with the commit
function select_files_to_add() {
    read -p "You're about to push your changes, would you like to add all files to the commit(y/n)? " ANSWER2
    if [ $ANSWER2 == 'y' ] || [ $ANSWER2 == 'Y' ];
    then
        git add .
    else
        read -a "Type all files you wish to add, separated by spaces" FILES_LIST
        for i in ${#FILES_LIST[@]}
        do
            git add $i
        done
    fi
}
