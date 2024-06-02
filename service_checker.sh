#!/bin/bash

serviceName=$1

# Check if the service is running
# use systemctl is you in linux
if launchctl list | grep -q $serviceName; then
    echo "$serviceName is running"
else
    echo "$serviceName is not running"
fi
