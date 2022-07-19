#!/bin/bash
##################
# Simple deploy script for a node app
##################
WORKDIR=/opt/app
cd $WORKDIR

updated=$(git pull 2>/dev/null)
if [ "$updated" == 'Already up-to-date.' ]; then
    # Nothing to do, exit cleanly
    exit 0
else
    # Code has been updated, rebuild the app
    npm install
    # And eventually restart the app
    supervisorctl restart nodeapp
fi
