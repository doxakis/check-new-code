#!/bin/bash

repo=$1
beforeUpdate=$2
afterUpdate=$3
logFile=$4

# Move to git repo.
cd $repo

# Fetch updates.
git fetch origin

# Check if any update.
if [ $(git rev-parse HEAD) != $(git rev-parse @{u}) ]; then
    # Change detected.
    echo "$(date '+%Y-%m-%d %H:%M:%S'): change detected" >> $logFile

    # Notify app before update.
    if [ -e "$beforeUpdate" ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S'): start $beforeUpdate" >> $logFile
        bash $beforeUpdate
        echo "$(date '+%Y-%m-%d %H:%M:%S'): end $beforeUpdate" >> $logFile
    fi

    # Update code
    echo "$(date '+%Y-%m-%d %H:%M:%S'): start merge" >> $logFile
    git merge origin/master
    echo "$(date '+%Y-%m-%d %H:%M:%S'): end merge" >> $logFile

    # Notify app after update.
    if [ -e "$afterUpdate" ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S'): start $beforeUpdate" >> $logFile
        bash $afterUpdate
        echo "$(date '+%Y-%m-%d %H:%M:%S'): end $beforeUpdate" >> $logFile
    fi
else
    # No changes
    echo "No changes"
    echo "$(date '+%Y-%m-%d %H:%M:%S'): No change" >> $logFile
fi
