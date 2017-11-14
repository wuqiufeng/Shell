#!/bin/sh

if [ -n $1 ]
then
 eth=$1
else 
 exit 1
fi

echo $(/sbin/ifconfig $eth|grep 'Link encap'|awk '{print $3}'|awk -F: '{print $2}')
echo $(/sbin/ethtool $eth|grep Speed|awk -F: '{print $2}')
echo $(/sbin/ethtool $eth|grep Duplex|awk -F: '{print $2}')
echo $(/sbin/ifconfig $eth|grep HWaddr|awk '{print $5}')
echo $(/sbin/ifconfig $eth|grep 'inet addr'|awk '{print $2}'|awk -F: '{print $2}')
echo $(/sbin/ifconfig $eth|grep Mask|awk '{print $4}'|awk -F: '{print $2}')

  
