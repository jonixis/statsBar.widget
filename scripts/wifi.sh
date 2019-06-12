#!/bin/bash

services=$(networksetup -listnetworkserviceorder | grep 'Hardware Port')

while read line; do
    sname=$(echo "$line" | awk -F  "(, )|(: )|[)]" '{print $2}')
    sdev=$(echo "$line" | awk -F  "(, )|(: )|[)]" '{print $4}')
    # echo "Current service: $sname, $sdev, $currentservice"
    if [ -n "$sdev" ]; then
        ifconfig "$sdev" 2>/dev/null | grep 'status: active' > /dev/null 2>&1
        rc="$?"
        if [ "$rc" -eq 0 ]; then
            networkName=$(networksetup -getairportnetwork "$sdev")
            [ $? -ne 0 ] && continue
            result="$sname@$(cut -c 24- <<< $networkName)@$(networksetup -getinfo Wi-Fi | grep "IP address" | grep "\." | cut -c 13-)"
            if [ -n "$result" ]; then
                echo "$result";
                exit 0;
            fi
        fi
    fi
done <<< "$services"

echo "--@--@--"
