#!/bin/bash

set -e

dotlist="dotlist"
project_root="$(cd "$(dirname "$0")"; pwd)"

# Use $CONFIG if set; otherwise, default to $HOME/.config
export CONFIG="${CONFIG:-"$HOME/.config"}"

# Expand variables like $CONFIG, $HOME, etc.
expand_vars() {
    local input="$1"
    eval "echo \"$input\""
}

# Pull: collect all files/dirs and git repos from dotlist into the project root
pull() {
    while IFS="|" read -r protocol source dest; do
        [[ -z "$protocol" ]] && continue
        [[ "$protocol" =~ ^# ]] && continue

        case "$protocol" in
            file)
                expanded_source=$(expand_vars "$source")
                if [[ ! -e "$expanded_source" ]]; then
                    echo "WARNING: File or directory '$expanded_source' not found. Skipping."
                    continue
                fi
                target="$project_root/$(basename "$expanded_source")"
                if [[ -d "$expanded_source" ]]; then
                    echo "Copy directory: $expanded_source → $target"
                    rm -rf "$target"
                    cp -r "$expanded_source" "$target"
                else
                    echo "Copy file: $expanded_source → $target"
                    cp -f "$expanded_source" "$target"
                fi
                ;;
            git)
                # Skip git protocol during pull
                echo "INFO: Skipping git protocol during pull."
                ;;
            *)
                echo "ERROR: Unknown protocol '$protocol'. Skipping."
                ;;
        esac
    done < "$dotlist"
}

# Push: copy from project root to original location ($CONFIG for files)
push() {
    while IFS="|" read -r protocol source dest; do
        [[ -z "$protocol" ]] && continue
        [[ "$protocol" =~ ^# ]] && continue

        case "$protocol" in
            file)
                expanded_source=$(expand_vars "$source")
                item_name=$(basename "$expanded_source")
                src="$project_root/$item_name"
                if [[ ! -e "$src" ]]; then
                    echo "WARNING: '$src' not found in project root. Skipping."
                    continue
                fi
                dest_dir=$(dirname "$expanded_source")
                mkdir -p "$dest_dir"
                if [[ -d "$src" ]]; then
                    echo "Copy directory: $src → $expanded_source"
                    rm -rf "$expanded_source"
                    cp -r "$src" "$expanded_source"
                else
                    echo "Copy file: $src → $expanded_source"
                    cp -f "$src" "$expanded_source"
                fi
                ;;
            git)
                if [[ -z "$source" || -z "$dest" ]]; then
                    echo "ERROR: git entry requires both source and destination."
                    continue
                fi
                expanded_dest=$(expand_vars "$dest")
                if [[ -d "$expanded_dest/.git" ]]; then
                    echo "INFO: Directory '$expanded_dest' already exists and is a git repo. Skipping clone."
                    continue
                fi
                echo "Cloning $source → $expanded_dest"
                git clone "$source" "$expanded_dest"
                ;;
            *)
                echo "ERROR: Unknown protocol '$protocol'. Skipping."
                ;;
        esac
    done < "$dotlist"
}

# Add: Add a new entry to dotlist (protocol|path|dest for git, protocol|path for file)
add() {
    local protocol=$1
    local source=$2
    local dest=$3
    if [[ "$protocol" == "file" ]]; then
        # Make path relative to project root if possible (store as $CONFIG/...)
        if [[ "$source" == "$CONFIG"* ]]; then
            entry="file|\$CONFIG${source#"$CONFIG"}"
        elif [[ "$source" == "$HOME"* ]]; then
            entry="file|\$HOME${source#"$HOME"}"
        else
            entry="file|$source"
        fi
        echo "$entry" >> "$dotlist"
        echo "Added: $entry"
    elif [[ "$protocol" == "git" ]]; then
        if [[ -z "$dest" ]]; then
            echo "Destination is required for git protocol."
            exit 1
        fi
        echo "git|$source|$dest" >> "$dotlist"
        echo "Added: git|$source|$dest"
    else
        echo "Invalid protocol: $protocol"
        exit 1
    fi
}

usage() {
    echo "Usage: $0 [pull|push|add]"
    echo "  pull             Pull files/repos as described in dotlist"
    echo "  push             Push files back to original locations"
    echo "  add file <path>  Add a file/directory by path"
    echo "  add git <url> <dest>  Add a git repo"
    exit 1
}

case "$1" in
    pull)
        pull
        ;;
    push)
        push
        ;;
    add)
        if [[ "$2" == "file" && -n "$3" ]]; then
            add file "$3"
        elif [[ "$2" == "git" && -n "$3" && -n "$4" ]]; then
            add git "$3" "$4"
        else
            usage
        fi
        ;;
    *)
        usage
        ;;
esac
