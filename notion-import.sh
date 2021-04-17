#!/bin/bash
# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG


function unzip_notion_export {
  export_folder="notion-export-$(date +%s)"
  mkdir -p "/tmp/$export_folder"
  cp $1 "/tmp/$export_folder/export.zip"
  cd "/tmp/$export_folder"
  unzip -o export.zip
}

function import_notes {
  unziped_folder=$(ls -I '*.*')
  notebook_name=''
  if [[ $1 ]]; then
    notebook_name=$1
  else
    notebook_name=$unziped_folder
  fi
  cd "$unziped_folder"
  joplin mkbook "$notebook_name"
  joplin use "$notebook_name"
  IFS=':' md_list=($(ls --quoting-style=shell | grep '\.md' | sed -r "s/\'\'/:/g"))
  for md in "${md_list[@]}"; do
    notename=${md//[$'\t\r\n']}
    notename=$(echo $notename | sed -r "s/'//g")
    newnotename=$(remove_hash $notename)
    joplin import "$notename" "$notebook_name"
  done
  IFS=' '
  echo "All notes imported to $notebook_name"
}

# read all notes in a notebook
function get_notes_list {
  joplin use "$1"
  joplin ls -l > /tmp/notes.txt
}

function go_thru_notes {
  z=0
  echo "" > /tmp/newnames.sh
  while read note; do
    let "z=z+1"
    extract_hash_name "$note"
  done < /tmp/notes.txt
  chmod +x /tmp/newnames.sh
  /tmp/newnames.sh
}

function remove_hash {
  echo $1
  strlen=${#1}
  IFS=" " read -ra my_array <<< "$1"
  arraylen=${#my_array[@]}
  notehash=${my_array[0]}
  newname=""
  cont=0
  for i in "${my_array[@]}"; do
    let "cont=cont+1"
    if [[ $cont -lt $arraylen ]]; then
      newname+="$i "
    fi
  done
  echo $newname
}

function extract_hash_name {
  strlen=${#1}
  IFS=" " read -ra my_array <<< "$1"
  arraylen=${#my_array[@]}
  notehash=${my_array[0]}
  newname=""
  cont=0
  for i in "${my_array[@]}"; do
    let "cont=cont+1"
    if [[ $cont -gt 3 && $cont -lt $arraylen ]]; then
      newname+="$i "
    fi
  done
  echo "renaming $notehash to $newname"
  echo "joplin ren $notehash \"$newname\"" >> /tmp/newnames.sh
}

# execute
unzip_notion_export $1
import_notes "$2"
get_notes_list "$2"
go_thru_notes
