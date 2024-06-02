#!/bin/bash

filePath=$1

if [ -f $filePath ]; then
    echo "File exists"
else
    echo "File does not exist"
fi

# create an array of ["Get", "Post", "Put", "Delete", "Patch", "Options", "Head", "Trace"]

methods=("GET" "POST" "PUT" "DELETE" "PATCH" "OPTIONS" "HEAD" "TRACE")

lineCount=$(wc -l <$filePath)

# create a map to store the count of each method
declare -A methodCount
declare -A ipAddressCount

success_http_code_count=0

max=0
maxIpAddress=""

for ((i = 1; i <= $lineCount; i++)); do
    # echo "Line $i: $(sed -n ${i}p $filePath)"
    # I want to split line into words on the basis of space
    words=($(sed -n ${i}p $filePath))
    method=${words[6]}
    method=${method:1}
    ipAddress=${words[1]}

    if [ -z ${methodCount[$method]} ]; then
        methodCount[$method]=0
    else
        methodCount[$method]=$((${methodCount[$method]} + 1))
    fi

    if [ -z ${ipAddressCount[$ipAddress]} ]; then
        ipAddressCount[$ipAddress]=0
    else
        ipAddressCount[$ipAddress]=$((${ipAddressCount[$ipAddress]} + 1))
    fi

    if [ ${ipAddressCount[$ipAddress]} -gt $max ]; then
        max=${ipAddressCount[$ipAddress]}
        maxIpAddress=$ipAddress
    fi

    http_status=${words[9]}
    if [ $http_status -ge 200 ] && [ $http_status -lt 300 ]; then
        success_http_code_count=$(($success_http_code_count + 1))
    fi
done

echo "Total number of request $lineCount"
echo "Success percentage $(($success_http_code_count * 100 / $lineCount))%"
echo "Most frequent ip address: $maxIpAddress having frequency $max"
