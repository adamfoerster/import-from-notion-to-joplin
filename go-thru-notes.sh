#!/bin/bash
# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
z=0
echo "" > /tmp/newnames.sh
while read note; do
  let "z=z+1"
  bash $SCRIPT_DIR/extract-hashes-from-notes-list.sh "$note"
  temp=$(echo "$note" | awk -F" " '{print $1}')
  joplin cat "$temp" | grep -P -o -e "(?:__|[*#])|\[(.*?)\]\(.*?\)" >> /tmp/ifntj-links
done < /tmp/notes.txt
chmod +x /tmp/newnames.sh
/tmp/newnames.sh
bash $SCRIPT_DIR/get-notes-list.sh "$1"
