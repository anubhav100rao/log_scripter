#!/bin/bash

directoryPath=$1

if [ -d $directoryPath ]; then
    echo "Directory exists"
else
    echo "Directory does not exist"
    exit 1
fi
# create a set to store the extension of files
extensions=("py", "cpp", "sh")

declare -A fileExtensionCount

for file in $(find $directoryPath -type f -not -path '*/\.*'); do
    extension=$(echo $file | rev | cut -d'.' -f1 | rev)
    if [ -z ${fileExtensionCount[$extension]} ]; then
        fileExtensionCount[$extension]=1
    else
        fileExtensionCount[$extension]=$((${fileExtensionCount[$extension]} + 1))
    fi
done

for key in "${extensions[@]}"; do
    echo "Extension: $key, Count: ${fileExtensionCount[$key]}"
done
