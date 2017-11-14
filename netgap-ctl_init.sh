#!/bin/sh

nFlag=`cat /etc/sysconfig/network|sed -n 2p|awk -F = '{print $2}'|awk -F . '{print $1}' `
echo $nFlag

#Setting environment variables
source /root/.bash_profile
source /etc/profile

while [ ! -S /var/lib/mysql/mysql.sock ]; do 
    sleep 1
done

sh /home/work/systool/script/database_init.sh

MYSQL=/usr/bin/mysql
username=root
password=123456

if [ "x$nFlag" == "xproxyin" ]; then
    echo "inner:$nFlag"
    $MYSQL -u$username -p$password netgap_conf < /home/work/systool/config/netgap_conf_in.sql
    $MYSQL -u$username -p$password netgap_log < /home/work/systool/config/netgap_log_in.sql

elif [ "x$nFlag" == "xproxyout" ]; then
    echo "outer:$nFlag"
    $MYSQL -u$username -p$password netgap_conf < /home/work/systool/config/netgap_conf_out.sql
    $MYSQL -u$username -p$password netgap_log < /home/work/systool/config/netgap_log_out.sql
else
    echo "Invalid parameter"
    exit 2;
fi

#Set crontab

echo "$?"

