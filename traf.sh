#!/bin/sh

if [ -n $1 ]
then
 eth=$1
else
 exit 1
fi

rb=$(/sbin/ifconfig $eth|awk '/bytes/{print $2}'|awk -F: '{print $2}')
sb=$(/sbin/ifconfig $eth|awk '/bytes/{print $6}'|awk -F: '{print $2}')

sleep 2

/sbin/ifconfig $eth|awk '/bytes/{print $2}'|awk -v rb1=$rb -F: '{printf "%.2f\n",($2-rb1)/(1024*2)}'
/sbin/ifconfig $eth|awk '/bytes/{print $6}'|awk -v sb1=$sb -F: '{printf "%.2f\n",($2-sb1)/(1024*2)}'
