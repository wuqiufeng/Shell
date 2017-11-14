#!/bin/sh

if [ -n $1 ]
then
 pt=$1
else
 exit 1
fi

df -h |grep $pt| awk '{print $2,$5}'
