#!/bin/bash
# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG

# UNZIP NOTION'S EXPORT ZIPFILE
# ARGS 1:zipfile_path
if [ $# -eq 0 ];then
    echo "ERROR: must supply the path of the export zip file"
    exit 1
fi
if ! test -f "$1"; then
    echo "ERROR: $1 does not exists."
    exit 1
fi
export_folder="notion-export-$(date +%s)"
mkdir -p "/tmp/$export_folder"
cp $1 "/tmp/$export_folder/export.zip"
cd "/tmp/$export_folder"
unzip -o export.zip