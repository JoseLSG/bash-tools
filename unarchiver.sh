#!/usr/bin/bash

# Finds all .rar files in subfolders of the current dir or the provided path.
# For each found, it will extract them into a subdir named "extracted" in the 
# parent directory where the .rar file was found.
# If a dir "extracted" exists and it's empty, it will unrar the file in that subdir.

list_of_rar_files() {
    find $1 -maxdepth 4 -type f -iname '*.rar'
}

extract_rar_files() {
    result_dir_str="/extracted"
    for filename in $( list_of_rar_files $1 ); do
        extract_folder_path=$( dirname $filename )$result_dir_str

        # unarchive if path exits and has no files OR if path doesnt exist
        if [[ ( -d $extract_folder_path && $( ls $extract_folder_path | wc -l ) -eq 0 ) || ! -d $extract_folder_path ]]; then
            mkdir -p $extract_folder_path
            unrar x $filename $extract_folder_path
        fi
    done
}

usage() {
        echo "Usage: $0 [DIRECTORY_PATH]"
        exit 1
}

# Main
if [ "$1" = "-h" ]; then
   usage
   exit 1
fi

if [ $# -eq 0 ]; then
    extract_rar_files `pwd`
elif [ -d $1 ]; then
    extract_rar_files $1
fi
