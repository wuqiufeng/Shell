#!/usr/bin/php -q
<?php
	# ./clearlog.sh  action log_path;
	#$argv[1]----clear/remove	
	#$argv[2]----log_path		

	$Log_path =  $argv[2];
	if($argv[1] == 'clear')
	{			
		if(!file_exists($argv[2]))
		{
			$str = "!!!log_path: $argv[2] 不存在！";
			system("echo $str");
			return -1; 	
		}	
		system("echo ''>$Log_path ");	
	}elseif($argv[1] == 'remove')
	{
		system("rm $Log_path  -f");		
	}else
	{
		$ret = "command not found!";
		system("echo $ret");
		return -1;
	}
	
	$ret = " clearlog $argv[1] $Log_path success!!";
	system("echo $ret");
?>
