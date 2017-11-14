#!/bin/bash

if [ $# -ne 1 ]
then
                echo "fail!!"
                exit 1
fi

DIR=/etc/syslog.conf
DIRBAK=${DIR}.backup
cp ${DIR} ${DIRBAK}
STR=*.\=debug

rm -f ${DIR}

var=`cat ${DIRBAK} | grep "${STR}"`

tmp1=`echo ${var} |awk -F@ '{printf $2}'`

sed s/${tmp1}/$1/  > ${DIR}  ${DIRBAK}

/etc/rc.d/init.d/syslog restart > /dev/null

echo $?
