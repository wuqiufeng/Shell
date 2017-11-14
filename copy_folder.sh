#!/usr/bin/php -q
<?php
	# ./cp_folder.sh  src_path  dst_path
	#$argv[1]----src_path
	#$argv[2]----dst_path

	# copy  src_path  to  dst_path	

	#///////////// copy proxy /////////////
	if(!is_dir($argv[2]))
	system("mkdir $argv[2]");
	
	if(!is_dir($argv[1]))
	{
		$str = "!!!src_path: $argv[1] 不存在！";
		system("echo $str");
		return -1; 	
	}
	$Src_path =  $argv[1].'/*';
	$Dst_path =  $argv[2];
				
	system("rm $Dst_path/*  -f");
	system("cp  $Src_path  $Dst_path -rf");
	system("chmod  666 $Dst_path/* ");
	
?>
