#!/bin/sh

#ps -C owtskdispatch,owtskmanager,owmsgforward,owftpserver,owfilesync,owftpmanager,owdbmanager,owlicense,owcron,owsysmonitor,owsmsalert,vsftpd -o pid=,ppid=,%cpu=,%mem=,cmd=|grep " 1 "|awk '{print $1,$3,$4,$5}'
ps -C owtskdispatch,owtskmanager,owmsgforward,owftpserver,owfilesync,owftpmanager,owlicense,owcron,owsysmonitor,owsmsalert,vsftpd -o pid=,ppid=,%cpu=,%mem=,cmd=|grep " 1 "|awk '{print $1,$3,$4,$5}'

ps -C mysqld -o pid=,%cpu=,%mem=,cmd=|awk '{print $1,$2,$3,$4}'
