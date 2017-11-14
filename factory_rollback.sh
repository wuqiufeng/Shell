#!/bin/sh
#


nFlag=`cat /etc/sysconfig/network|sed -n 2p|awk -F = '{print $2}'|awk -F . '{print $1}' `
echo $nFlag

if [ $# != 2 ]
then
	echo "Useage:factory_rollback dbuser dbpassword"
	exit 1
fi
[ $1 ] && dbuser=$1
[ $2 ] && dbpassword=$2

MYSQL=/usr/bin/mysql

FACTORYDIR=/home/work/systool/config
if [ ! -d $FACTORYDIR ]
then
	echo "fail"
	exit 2
fi

if [ ! -f ${FACTORYDIR}/netgap_conf_in.sql ]
then
	 echo "fail"
	 exit 3
fi

if [ ! -f ${FACTORYDIR}/netgap_log_in.sql ]
then
	 echo "fail"
	 exit 3
fi

if [ ! -f ${FACTORYDIR}/netgap_conf_out.sql ]
then
	 echo "fail"
	 exit 3
fi

if [ ! -f ${FACTORYDIR}/netgap_log_out.sql ]
then
	 echo "fail"
	 exit 3
fi

if [ "x$nFlag" == "xproxyin" ]; then
    echo "inner:$nFlag"
    $MYSQL -u$dbuser -p$dbpassword netgap_conf < /home/work/systool/config/netgap_conf_in.sql
    $MYSQL -u$dbuser -p$dbpassword netgap_log < /home/work/systool/config/netgap_log_in.sql

elif [ "x$nFlag" == "xproxyout" ]; then
    echo "outer:$nFlag"
    $MYSQL -u$dbuser -p$dbpassword netgap_conf < /home/work/systool/config/netgap_conf_out.sql
    $MYSQL -u$dbuser -p$dbpassword netgap_log < /home/work/systool/config/netgap_log_out.sql
else
    echo "Invalid parameter"
    exit 2;
fi

#/opt/oneway/script/sshd_stop
#DNS=''
#FILE_PATH=/etc/resolv.conf
#echo "nameserver $DNS" > $FILE_PATH

echo "successful"
