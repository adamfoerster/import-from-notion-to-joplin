#!/bin/bash
# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG


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
