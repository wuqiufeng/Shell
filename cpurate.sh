#########################################################################
# File Name: cpurate.sh
# Author: hyq
# Created Time: Fri 02 Jun 2017 09:39:17 AM CST
#########################################################################
#!/bin/bash
#cpu_rate check

cpu_rate_usr=$(top -b -n 1 | grep Cpu | awk '{print $2}'| cut -f 1 -d ".")
cpu_rate_sys=$(top -b -n 1 | grep Cpu | awk '{print $3}'| cut -f 1 -d ".")
cpu_rate_ni=$(top -b -n 1 | grep Cpu | awk '{print $4}'| cut -f 1 -d ".")
cpu_rate_id=$(top -b -n 1 | grep Cpu | awk '{print $5}'| cut -f 1 -d ".")
echo "用户占用:$cpu_rate_usr% 系统占用:$cpu_rate_sys% 优先占用:$cpu_rate_ni% 空闲:$cpu_rate_id%"   
