#!/bin/sh
#
if [ $# != 3 ]
then
	echo "Useage:backup_conf dbuser dbpassword destfilepath"
	exit 1
fi
[ $1 ]&&dbuser=$1
[ $2 ]&&dbpassword=$2

NOWTIME=`date +%Y%m%d%H%M%S`
DESTFILEPATH=$3
DESTDIR=`dirname $DESTFILEPATH`
echo DESTDIR=$DESTDIR

MYSQLDUMP=/usr/local/mysql/bin/mysqldump

if [ ! -d $DESTDIR ]
then
	mkdir -p $DESTDIR
fi

function permsg()
{
	echo "error:$MYSQLDUMP access error!!"
}

MYSQLDUMP_CHECK=`$MYSQLDUMP -u${dbuser} -p${dbpassword} netgap_conf t_tunnel_policy > $DESTDIR/t_tunnel_policy.sql 2>&1;echo $?`
if [ $MYSQLDUMP_CHECK -ne 0 ]
then
	echo "1111111"
	permsg
	exit 1
fi
MYSQLDUMP_CHECK=`$MYSQLDUMP -u${dbuser} -p${dbpassword} netgap_conf t_client_acl > $DESTDIR/t_client_acl.sql 2>&1;echo $?`
if [ $MYSQLDUMP_CHECK -ne 0 ]
then
	echo "22222"
    permsg
    exit 1
fi
MYSQLDUMP_CHECK=`$MYSQLDUMP -u${dbuser} -p${dbpassword} netgap_conf t_login_conf > $DESTDIR/t_login_conf.sql 2>&1;echo $?`
if [ $MYSQLDUMP_CHECK -ne 0 ]
then
	echo "33333"
        permsg
        exit 1
fi
MYSQLDUMP_CHECK=`$MYSQLDUMP -u${dbuser} -p${dbpassword} netgap_conf t_nic_conf > $DESTDIR/t_nic_conf.sql 2>&1;echo $?`
if [ $MYSQLDUMP_CHECK -ne 0 ]
then
	echo "4444"
	permsg
	exit 1
fi

cd $DESTDIR
#tar zcf backup_conf_$NOWTIME.tar.gz *.sql
if [ -f /home/work/proxy/config/sysconf.xml ]; then
    cp /home/work/proxy/config/sysconf.xml $DESTDIR
fi
tar zcf $DESTFILEPATH *.sql sysconf.xml
rm -rf *.sql sysconf.xml

#rm -f /backup/system/network_back_conf/*
#cp -f /etc/sysconfig/network-scripts/ifcfg-eth* /backup/system/network_back_conf

#echo backup_conf_$NOWTIME.tar.gz

