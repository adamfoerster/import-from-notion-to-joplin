#!/bin/bash
# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG

# read all notes in a notebook
echo "using notebook $1"
joplin use "$1"
joplin ls -l > /tmp/notes.txt