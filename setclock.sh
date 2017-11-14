#!/usr/bin/php -q
<?php
#./setclock.sh set_time
#---------Change Time Zone-----
system("cp /etc/localtime   /etc/localtime.bak  -f ");
system("cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime  -f");

system("cp /etc/sysconfig/clock  /etc/sysconfig/clock.bak -f");
system("echo ''>/etc/sysconfig/clock ");
system("echo 'ZONE=Asia/Shanghai'>>/etc/sysconfig/clock ");
system("echo 'UTC=false'>>/etc/sysconfig/clock ");
system("echo 'ARC=false'>>/etc/sysconfig/clock ");

#---------Change Time--------
$set_date = $argv[1];
$set_time = $argv[2];
$str_time = $set_date." ".$set_time;
system("date -s '$str_time' ");

#---------Write Time To  CMOS-------
system("clock -w ");




?>
