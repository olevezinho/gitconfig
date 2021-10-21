#!/bin/bash

create_pull_request() {
	read -p "Do you wish to create a pull request (y/n)? " ANSWER3
	if [ $ANSWER3 == 'y' ] || [ $ANSWER3 == 'Y' ];
	then
	    gh pr create --base $1 #--head $2
            exit 0
	else
	    echo "No PR was requested!"
	    exit 0
	fi
}
