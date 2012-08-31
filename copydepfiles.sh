#! /usr/bin/env bash

# Arguments:
# 1. destination folder


function forfile {
	dest=$1
	file=$2

	path=$(dirname "$file")
	newpath=$(echo "$1/$path" | sed -e "s/ /_/g")

	mkdir -p $newpath
	cp -r -p "$file" $(echo "$1/$file" | sed -e "s/ /_/g")
	touch -r "$path" $newpath
}

export -f forfile
find . -name "*.d" -type f -exec bash -c "forfile $1 '{}'" \;
