#!/usr/bin/php -q
<?php
# ./backup.sh  path_file
#$argv[1]----path_file

$CUR_DIR=$argv[1];
#///////////// backup /home/work/web/conf ////////////
$src_config_web = "/home/work/web/config";
$dst_config_web = $argv[1]."/"."config_web";

if(!is_dir($dst_config_web))
	system("mkdir $dst_config_web -p");
	
if(!is_dir($src_config_web))
{
	$str_web = "!!!src_config_web: $src_config_web 不存在！";
	system("echo $str_web");
	return -1; 	
}
	
system("cp  $src_config_web/*  $dst_config_web -rf");

#///////////// backup /home/work/proxy/conf ////////////
$src_config_proxy = "/home/work/proxy/config";
$dst_config_proxy = $argv[1]."/"."config_proxy";

if(!is_dir($dst_config_proxy))
	system("mkdir $dst_config_proxy  -p");
	
if(!is_dir($src_config_proxy))
{
	$str_proxy = "!!!src_config_proxy: $src_config_proxy 不存在！";
	system("echo $str_proxy");
	return -1; 	
}
	
system("cp  $src_config_proxy/*  $dst_config_proxy -rf");

#///////////// cp restore.sh  ////////////
system("cp  script/restore.sh  $CUR_DIR -rf");

#///////////// tar -czvf ////////////
$name_tar = $argv[1]."/"."config_work.tar.gz";
system("cd $CUR_DIR; tar -czf  $name_tar  config_web   config_proxy  restore.sh");	
?>
