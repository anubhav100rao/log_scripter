#!/bin/bash

directoryPath=$1

if [ -d $directoryPath ]; then
    echo "Directory exists"
else
    echo "Directory does not exist"
    exit 1
fi

declare -A fileExtensionCount

for file in $(find $directoryPath -type f -not -path '*/\.*'); do
    extension=$(echo $file | rev | cut -d'.' -f1 | rev)
    if [ -z ${fileExtensionCount[$extension]} ]; then
        fileExtensionCount[$extension]=1
    else
        fileExtensionCount[$extension]=$((${fileExtensionCount[$extension]} + 1))
    fi
done

extension="py"
echo "$extension files: ${fileExtensionCount[$extension]}"

for key in "${fileExtensionCount[@]}"; do
    echo "Extension: $key, Count: ${fileExtensionCount[$key]}"
done
