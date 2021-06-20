#!/bin/bash
# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG


# IMPORT ALL .MD FILES IN CURRENT DIR 
# AS NOTES TO A NOTEBOOK
# ARGS 1:zipfile_path
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
unziped_folder=$(ls -I '*.*')
echo "I will use $1"
notebook_name="$1"
echo "the notebook_name will be $notebook_name"
cd "$unziped_folder"
joplin mkbook "$notebook_name"
joplin use "$notebook_name"
IFS=':' md_list=($(ls --quoting-style=shell | grep '\.md' | sed -r "s/\'\'/:/g"))
for md in "${md_list[@]}"; do
  notename=${md//[$'\t\r\n']}
  notename=$(echo $notename | sed -r "s/'//g")
  newnotename=$($SCRIPT_DIR/remove-hash.sh $notename)
  if [[ $(joplin import "$notename" "$notebook_name") ]]; then
    echo "note $notename imported to $notebook_name"
  else
    echo "one note skipped"
  fi
done
IFS=' '
echo "All notes imported to $notebook_name"