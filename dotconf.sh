#!/bin/bash

usr_home=$HOME
if [[ -z $usr_home ]]; then
    echo "Error: The user home directory is not defined."
    exit 1
fi
usr_conf=$usr_home/.config
cdir=$(dirname "$0")

files=(
    "$usr_conf/nvim"
)

pull() {
    for file in "${files[@]}"; do
        fc="${file##*/}"
        fn="${file%/*}"
        echo "running: cp -rf $fn/$fc $cdir/$fc"
    done
}

push() {
    for file in "${files[@]}"; do
        fc="${file##*/}"
        fn="${file%/*}"
        echo "running: cp -rf ./$cdir/$fc $fn"
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
