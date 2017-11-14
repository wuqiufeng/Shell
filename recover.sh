#!/bin/sh
#
if [ $# != 4 ]
then
	echo "Useage:recover_conf dbuser dbpassword backupname srcdir"
	exit 1
fi
NOWTIME=`date +%Y%m%d%H%M%S`
[ $1 ]&&dbuser=$1
[ $2 ]&&dbpassword=$2
[ $3 ]&&backupname=$3

MYSQL=/usr/local/mysql/bin/mysql

function permsg()
{
	echo "error:mysql recover fail!!"
}

DESTDIR=$4
#DESTDIR=`dirname $DESTFILEPATH`
echo DESTDIR=$DESTDIR

if [ ! -d $DESTDIR ]
then
	echo permsg
	exit 2
fi

#LOGDIR=/audit/db/log
#if [ ! -d $LOGDIR ]
#then
#	mkdir -p $LOGDIR
#fi

logfile=/home/work/systool/log/recover_conf.log
if [ ! -f $logfile ]
then
    touch $logfile
fi

cd $DESTDIR
tar zxvf $3 
if [ $? -ne 0 ]
then
	echo permsg
	exit 1
fi

if [ ! -f t_tunnel_policy.sql ]
then
	echo "<======="`date +%Y%m%d%H%M%S`"=======>" 		>>$logfile
	echo "no exist tsysconfig.sql"  			>>$logfile
	echo permsg
	exit 1
fi

if [ ! -f t_client_acl.sql ]
then
	echo "<======="`date +%Y%m%d%H%M%S`"=======>" 		>>$logfile
	echo "no exist ttaskpublicinfo.sql"			>>$logfile
	echo permsg
	exit 1
fi

if [ ! -f t_login_conf.sql ]
then
	echo "<======="`date +%Y%m%d%H%M%S`"=======>" 		>>$logfile
	echo "no exist ttaskfileinfo.sql"			>>$logfile
	echo permsg
	exit 1
fi

if [ ! -f t_nic_conf.sql ]
then
	echo "<======="`date +%Y%m%d%H%M%S`"=======>" 		>>$logfile
	echo "no exist tftpservconf.sql"			>>$logfile
	echo permsg
	exit 1
fi

MYSQL_CHECK=`mysql -u${dbuser} -p${dbpassword} netgap_conf < t_tunnel_policy.sql 2>>$logfile;echo $?`
if [ $MYSQL_CHECK -ne 0 ]
then
        permsg
exit 1
fi

MYSQL_CHECK=`mysql -u${dbuser} -p${dbpassword} netgap_conf < t_client_acl.sql 2>>$logfile;echo $?`
if [ $MYSQL_CHECK -ne 0 ]
then
        permsg
exit 1
fi

MYSQL_CHECK=`mysql -u${dbuser} -p${dbpassword} netgap_conf < t_login_conf.sql 2>>$logfile;echo $?`
if [ $MYSQL_CHECK -ne 0 ]
then
        permsg
exit 1
fi

MYSQL_CHECK=`mysql -u${dbuser} -p${dbpassword} netgap_conf < t_nic_conf.sql 2>>$logfile;echo $?`
if [ $MYSQL_CHECK -ne 0 ]
then
        permsg
exit 1
fi


rm -rf *.sql

#cp -f /backup/system/network_back_conf/* /etc/sysconfig/network-scripts/
#sh /opt/oneway/script/gw_restart

echo "mysql recover successful"
