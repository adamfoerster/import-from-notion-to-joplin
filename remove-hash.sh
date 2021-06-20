#!/bin/bash
# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG

# RETURNS A STRING WITHOUT THE LAST WORD
# ARGS 1:string
echo "$1"
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