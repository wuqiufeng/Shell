#!/usr/bin/php -q
<?php
# ./selfstart.sh  Name on;
#$argv[1]----Name	
#$argv[2]----on/off
$Allow_app = array('sshd','httpd','mysqld');
$Name =  $argv[1];
$Selfstart = $argv[2] == ''?'off':$argv[2];

if(in_array($Name,$Allow_app))
{
	$cmd_str = "chkconfig $Name $Selfstart ";
	system($cmd_str);
	$ret = "ok";
	system("echo $ret");
	return 1;
}else
{
	$ret = "$Name-selfstart-status  is not allowed to change!";
	system("echo $ret");
	return -1;
}

?>
