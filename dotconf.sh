#!/bin/bash

usr_home=$HOME
if [[ -z $usr_home ]]; then
    echo "Error: The user home directory is not defined."
    exit 1
fi

usr_conf="${CONFIG:-"$usr_home/.config"}"
cdir=$(dirname "$0")
CONFIG=$usr_conf

conf_list_file="dotlist"
files=()

# check if the file dotlist existst
if [[ ! -f "$cdir/$conf_list_file" ]]; then
    echo "No conflist file found, creating one"
    touch -- "$cdir/$conf_list_file"
fi

# read config list file and use those paths
while IFS= read -r line; do
    if [[ "$line" =~ ^# ]] || [[ -z "$line" ]]; then
        continue
    fi

    eval "expanded_line=\"$line\""
    files+=("$expanded_line")
done < $conf_list_file

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

add_to_conf() {
    echo "$1"
    echo "$1" >> "$cdir/$conf_list_file"
}

case $1 in
    pull)
        pull
        ;;
    push)
        push
        ;;
    add)
        add_to_conf $2
        ;;
    *)
        echo "Error: Invalid command."
        echo "Usage: dotconf.sh [pull|push|add]"
        exit 1
        ;;
esac
