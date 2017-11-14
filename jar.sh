#!/bin/sh
export JAVA_HOME=/opt/java/jdk1.5.0_13
export JAR_FILE=/opt/oneway/bin/DBJAVA/DBSyn.jar
#!/bin/sh

if test $# -lt 2 -o $# -gt 4; then
echo "USAGE: $0 <start|stop>  [file] <port>"
exit
fi

case $1 in
start)
	if test $# -ne 4;then
		echo "USAGE: $0 <start> <file> <port>"
	else
		java -DDBSync=$4 -jar $JAR_FILE $3 $2 & 2>&1 >/dev/null;
	fi
;;
stop)
	if test $# -ne 2;then
		echo "USAGE: $0 <stop> <port>"
	else
		ID=`ps -ef | grep $JAR_FILE | grep $2 | grep -v grep | awk '{print $2}'`
		ID_NUM=`echo $ID|bc`;
		#echo $ID
		if test $ID != $ID_NUM; then
			echo "error caused by PID format or process not exist";
		else
			kill $ID 2>/dev/null;
		fi
	fi
;;
status)
	if test $# -ne 2;then
		echo "USAGE: $0 <stop> <port>"
	else
		ID=`ps -ef | grep $JAR_FILE | grep $2 | grep -v grep | awk '{print $2}'`
		ID_NUM=`echo $ID|bc`;
		#echo $ID
		if test $ID != $ID_NUM; then
			echo "error caused by PID format or process not exist";
		else
			#echo $ID;
			echo "OW0000";
		fi
	fi
;;
esac
