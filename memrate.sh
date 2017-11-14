#########################################################################
# File Name: mem_rate.sh
# Author: hyq
# Created Time: Fri 02 Jun 2017 10:28:48 AM CST
#########################################################################
#!/bin/bash
MemTotal=$(cat /proc/meminfo | grep 'MemTotal' | awk '{print $2}'| cut -f 1 -d ".")
MemFree=$(cat /proc/meminfo | grep 'MemFree' | awk '{print $2}'| cut -f 1 -d ".")
#echo "memory_total:$MemTotal kb"
#echo "memory_free:$MemFree kb"
echo "$MemFree $MemTotal"|awk '{printf ("%.2f\n",$1/$2)}'

