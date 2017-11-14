#!/bin/sh

top -bn1|awk '/Cpu\(s\)/{printf "%.2f\n",100-$5;}/Mem:/{printf "%.2f\n",$4/$2*100;}'

#/usr/bin/free | grep "/" | awk '{printf "%.2f\n",$3/($3+$4)*100}'
#/usr/bin/top -bn2 |awk '/ni, /{printf "%.2f\n",100-$5;}'|sed -n 2p
