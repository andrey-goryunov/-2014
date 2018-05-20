#!/bin/bash 
vendor=1a86
product=7523

set -x

for i in /sys/bus/usb/devices/* 
do 
    if [[ -e "$i/idVendor" ]]
    then
        vid=`cat "$i/idVendor"`
        pid=`cat "$i/idProduct"`
        if [[ ($vid == $vendor) && ($pid == $product)]]
        then
            echo -n "suspend" > "$i/power/level"
            sleep 3s;
           # echo -n "on" > "$i/power/level"
           # sleep 3s;
            break;
        fi
    fi
done
exit 0
