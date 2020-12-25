#!/usr/bin/bash

# find . -maxdepth 4 -iname '*.rar' -exec echo "File is {}" \; | wc -l
# find . -maxdepth 4 -type f -iname '*.rar' -execdir ls \;
# dirname /media/jls/271BE2424B09149C/torrents/pretome/downloads/Westworld.S01E04.1080p.HDTV.x264-BATv/westworld.s01e04.1080p.hdtv.x264-batv.rar
# find . -maxdepth 4 -type f -not -iname '*.r*' | grep -v -E ".nfo|.sfv|.mobi|.png|.jpg|.epub|.srt|.exe"

# - find all .rar files starting at parent dir from input param
# - if extrated subfolder doesnt exist or it is empty, run unrar
# - else move to next

# findrar () {
#     for i in `find $1 -maxdepth 4 -type f -iname '*.rar'`
#         do
#         echo "$i"
#     done
# }

list_of_rar_files () {
    find $1 -maxdepth 4 -type f -iname '*.rar'
}

# extract_folder () {
#     echo "code 1"
#     return $( dirname $1 )/extracted
# }

# num_files_in_extract_folder () {
#     echo "code 2"
#     return ls $( extract_folder $1 ) | wc -l
# }

extract_rar_files () {
    for filename in $( list_of_rar_files $1 ); do
        extract_folder_path=$( dirname $filename )/extracted

        if [[ ( -d $extract_folder_path && $( ls $extract_folder_path | wc -l ) -eq 0 ) || ! -d $extract_folder_path ]]; then
            echo "inside"
            echo $(dirname $filename)/extracted
            mkdir -p $extract_folder_path
            unrar x $filename $extract_folder_path
            
        fi
    done
}

# Main
if [ $# -eq 0 ]; then
    extract_rar_files `pwd`
    # for i in $( list_of_rar_files `pwd` ); do
    #     echo $i
    # done
elif [ -d $1 ]; then
    extract_rar_files $1
    # for i in $( list_of_rar_files $1 ); do
    #     echo $i
    # done
fi

