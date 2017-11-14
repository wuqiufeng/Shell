#!/usr/bin/php -q
<?php
# ./switch.sh  Name start;
#$argv[1]----Name	
#$argv[2]----start/stop
$Allow_app = array('sshd','httpd','mysqld');
$Name =  $argv[1];
$Switch = $argv[2] == ''?'stop':$argv[2];

echo "start--------------------------";

if(!in_array($Name,$Allow_app))
{
	$ret = "$Name is not allowed to change!";
	system("echo $ret");
	return -1;
}

if($Name == 'sshd')
{
	$ret = "ok";
	system("echo $ret");
	$cmd_str =  "/etc/init.d/sshd $Switch";
	system($cmd_str);
	return 1;
}elseif($Name == 'mysqld')
{
	$ret = "ok";
	system("echo $ret");
	$cmd_str =  "/etc/init.d/mysqld $Switch &";
	system($cmd_str);
	return 1;

}
else
{
	$ret = "nothing do!";
	system("echo $ret");
	return 1;
}

?>
