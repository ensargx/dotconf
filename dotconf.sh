#!/bin/bash

usr_home=$HOME
if [[ -z $usr_home ]]; then
    echo "Error: The user home directory is not defined."
    exit 1
fi
usr_conf=$usr_home/.config
cdir=$(dirname "$0")

# todo: create a file named dotfiles, evaluate paths from that file
# files should not be written in this file 
files=(
    "$usr_conf/nvim"
    "$usr_home/.tmux.conf"
)

# check if a path is a directory or file 
check_path() {
    local path="$1" # path to check

    if [[ -f $path ]]; then
        echo "f"
    elif [[ -d $path ]]; then
        echo "d"
    else 
        echo "n"
    fi
}

pull() {
    for file in "${files[@]}"; do
        fc="${file##*/}" # Get filename
        fn="${file%/*}"  # Get directory name

        # check if fc is a directory 
        local result=$(check_path "$fn/$fc")
        
        # handle the case if directory
        if [[ $result == "d" ]]; then 
            # create a directory if not exists 
            /bin/rm -rf -- "$cdir/$fc"
            /bin/cp -r -- "$fn/$fc" "$cdir"

        # handle the case if file
        elif [[ $result == "f" ]]; then
            /bin/rm -f -- "$cdir/$fc"
            /bin/cp -f -- "$fn/$fc" "$cdir"

        else 
            # handle error case
            echo "Unknown error accured!"
            exit -1
        fi 
        # echo "running: cp -rf $fn/$fc $cdir/"
        # cp -rf $fn/$fc $cdir/$fc
    done
}

push() {
    echo "todo: fix"
    for file in "${files[@]}"; do
        fc="${file##*/}"
        fn="${file%/*}"
        echo "running: cp -rf $cdir/$fc $fn"
        cp -rf $cdir/$fc $fn
    done
}

case $1 in
    pull)
        pull
        ;;
    push)
        push
        ;;
    add)
        file_or_dir=$2
        echo "Adding file or directory: $file_or_dir"
        ;;
    *)
        echo "Error: Invalid command."
        echo "Usage: dotconf.sh [pull|push|add]"
        exit 1
        ;;
esac
