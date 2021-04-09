#!/bin/bash

# read all notes in a notebook
function get_notes_list {
  joplin use $1
  joplin ls -l > notes.txt
}

function go_thru_notes {
  z=0
  touch newnames.sh
  while read note; do
    let "z=z+1"
    extract_hash_name "$note"
  done < notes.txt
  chmod +x ./newnames.sh
  ./newnames.sh
}

function extract_hash_name {
  strlen=${#1}
  read -ra my_array <<< "$1"
  arraylen=${#my_array[@]}
  notehash=${my_array[0]}
  newname=""
  cont=0
  for i in "${my_array[@]}"; do
    let "cont=cont+1"
    if [[ $cont>3 && $cont<$arraylen ]]; then
      newname+="$i "
    fi
  done
  echo "renaming $notehash to $newname"
  echo "joplin ren $notehash \"$newname\"" >> newnames.sh
}

# execute
get_notes_list $1
go_thru_notes
