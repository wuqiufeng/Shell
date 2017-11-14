#!/bin/sh
CUR_DIR=`pwd`
cd $CUR_DIR
#echo "restore proxy/config ..."
cp -f -R config_proxy/* /home/work/proxy/config
#echo "restore proxy/config finished."
#echo "restore web/config ..."
cp -f -R config_web/*   /home/work/web/config
#echo "restore web/config finished."
