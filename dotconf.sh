#!/bin/bash

usr_home=$HOME
if [[ -z $usr_home ]]; then
    echo "Error: The user home directory is not defined."
    exit 1
fi
usr_conf=$usr_home/.config

files=(
    "$usr_conf/nvim/"
)

check_file() {
    if [[ -f $1 ]]; then
        return 0
    fi
    if [[ -d $1 ]]; then
        return 1
    fi
    return -1
}

pull() {
    for file in "${files[@]}"; do
        check_file "$file"
        case $? in
            0)
                ts=${file%/*}
                tn=${ts##*/}
                echo "Copying file: $file"
                echo "tn=$tn"
                echo "ts=$ts"
                ;;
            1)
                ts=${file%/}
                tn=${ts##*/}
                cp -rf $ts $tn
                ;;
            -1)
                echo "Error: The file or directory does not exist."
                echo "File: $file"
                exit 1
                ;;
        esac
    done
}

push() {
    echo "Pushing dotfiles to the files array."
    for file in "${files[@]}"; do
        echo "Push File: $file"
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
