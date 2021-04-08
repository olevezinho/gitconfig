#!/bin/bash
# Description: The following script can be used to kill all ssh runnign processes and sync the account with github via ssh
# Author: Filipe
# Last changed: 30/12/2020
# NOTES: This script needs to be dot source, or else it won't work

# Store Pid in the $pid variable
sshwc=`ps | grep ssh | awk '{print $1}' | wc -l`
pid=`ps | grep ssh | awk '{print $1}'`

# Find all running processes and kill them
if [ "$sshwc" -ge 1 ]; then
    echo "One or more ssh process were found, do you wish to kill all processes? (y/n)"
    read ANSWER
    if [ $ANSWER == 'y' ] || [ $ANSWER == 'Y' ];
    then
        for item in "$pid"
        do
            kill -9 $item
        done
    else exit -1
    fi
else 
    echo "No ssh processes are running at the moment!"
fi

# Start the ssh agent
echo "Hope you DOT SOURCED the syncscript.bash"
sleep 1
echo "Do you wish to start the ssh-agent? (y/n)"
    read ANSWER
if [ $ANSWER == 'y' ] || [ $ANSWER == 'Y' ];
    then
        # start ssh agent
        eval `ssh-agent -s`
        # add the ssh key
        ssh-add ~/.ssh/github_id
else exit -1
fi

# pull changes before committing them
git pull

if [ $? != '0' ];
    then
        echo "You forgot to dot source the script, or you're not in the proper directory"
else
    echo "Do you want to commit and push your changes (y/n)?"
    read ANSWER
    if [ $ANSWER == 'y' ] || [ $ANSWER == 'Y' ];
    then
        echo "You're about to push your changes"
        sleep 1
        echo ...
        sleep 1
        echo "What's the message you desire to type?"
        read MESSAGE
        echo ..
        git commit -m "$MESSAGE"
        sleep 1
        echo .
        echo "What's the name of the current active branch?"
        read MYBRANCH
        echo "What's the name of the destination branch?"
        read REPOBRANCH
        git push -u $REPOBRANCH $MYBRANCH
    else
        echo "Everything seems up to date, all commit/pull/push operations will work until you close this session"
    fi
fi

