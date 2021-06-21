#!/bin/bash
# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG


notebook_name=''
unziped_folder=$(ls -I '*.*')
if [[ $1 ]]; then
  notebook_name="$1"
else
  notebook_name="$unziped_folder"
fi

# execute
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
bash $SCRIPT_DIR/unzip-notion-export.sh "$1"
bash $SCRIPT_DIR/import-notes.sh "$notebook_name"
bash $SCRIPT_DIR/get-notes-list.sh "$notebook_name"
bash $SCRIPT_DIR/go-thru-notes.sh "$notebook_name"
