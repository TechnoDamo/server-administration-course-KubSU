#!/bin/bash

old_IFS=$IFS
IFS=':'

for dir in $PATH; do
    count=0
    if [ -d "$dir" ] && [ -r "$dir" ]; then
        shopt -s dotglob nullglob
        files=( "$dir"/* )
        count=${#files[@]}
        shopt -u dotglob nullglob
    fi
    echo "$dir => $count"
done

IFS=$old_IFS
