#!/usr/bin/bash

# Finds all .rar files in subfolders of the current dir or the provided path.
# For each found, it will extract them into a subdir named "extracted" in the 
# parent directory where the .rar file was found.

list_of_rar_files () {
    find $1 -maxdepth 4 -type f -iname '*.rar'
}

extract_rar_files () {
    for filename in $( list_of_rar_files $1 ); do
        extract_folder_path=$( dirname $filename )/extracted

        # unarchive if path exits and has no files OR if path doesnt exist
        if [[ ( -d $extract_folder_path && $( ls $extract_folder_path | wc -l ) -eq 0 ) || ! -d $extract_folder_path ]]; then
            mkdir -p $extract_folder_path
            unrar x $filename $extract_folder_path
        fi
    done
}

# Main
if [ $# -eq 0 ]; then
    extract_rar_files `pwd`
elif [ -d $1 ]; then
    extract_rar_files $1
fi
