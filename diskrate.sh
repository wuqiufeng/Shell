#########################################################################
# File Name: disk.sh
# Author: hyq
# Created Time: Mon 24 Jul 2017 01:54:01 PM CST
#########################################################################
#!/bin/bash
count=$(df | awk 'END{print NR}')
sda1=$(df | awk '{print $2}' | sed -n '2p')
sda2=$(df | awk '{print $2}' | sed -n '3p')
sda3=$(df | awk '{print $2}' | sed -n '4p')
sda4=$(df | awk '{print $2}' | sed -n '5p')
sda5=$(df | awk '{print $2}' | sed -n '6p')
sda6=$(df | awk '{print $2}' | sed -n '7p')
sda7=$(df | awk '{print $2}' | sed -n '8p')
sda8=$(df | awk '{print $2}' | sed -n '9p')
sda9=$(df | awk '{print $2}' | sed -n '10p')
sda10=$(df | awk '{print $2}' | sed -n '11p')
sdau1=$(df | awk '{print $4}' | sed -n '2p')
sdau2=$(df | awk '{print $4}' | sed -n '3p')
sdau3=$(df | awk '{print $4}' | sed -n '4p')
sdau4=$(df | awk '{print $4}' | sed -n '5p')
sdau5=$(df | awk '{print $4}' | sed -n '6p')
sdau6=$(df | awk '{print $4}' | sed -n '7p')
sdau7=$(df | awk '{print $4}' | sed -n '8p')
sdau8=$(df | awk '{print $4}' | sed -n '9p')
sdau9=$(df | awk '{print $4}' | sed -n '10p')
sdau10=$(df | awk '{print $4}' | sed -n '11p')
diskTotal=$(echo "$sda1 $sda2 $sda3 $sda4 $sda5 $sda6 $sda7 $sda8 $sda9 $sda10 "|awk '{printf ("%d\n",$1+$2+$3+$4+$5+$6+$7+$8+$9+$10)}')
#echo $diskTotal
diskAvai=$(echo "$sdau1 $sdau2 $sdau3 $sdau4 $sdau5 $sdau6 $sdau7 $sdau8 $sdau9 $sdau10 "|awk '{printf ("%d\n",$1+$2+$3+$4+$5+$6+$7+$8+$9+$10)}')
#echo $diskAvai
echo "$diskTotal $diskAvai"|awk '{printf("%.2f\n",$2/$1)}'
