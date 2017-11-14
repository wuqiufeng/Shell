#!/bin/sh

nFlag=`cat /home/work/systool/config/isFirstStart`
echo $nFlag

if [ "x$nFlag" == "xTRUE" ]; then
    echo "isFirstStart:$nFlag"
    /home/work/systool/script/netgap-ctl_init.sh
    echo "FALSE" > /home/work/systool/config/isFirstStart
elif [ "x$nFlag" == "xFALSE" ]; then
    echo "isFirstStart:$nFlag"
    exit 0
else
    echo "Invalid parameter"
    exit 2;
fi

echo "$?"

