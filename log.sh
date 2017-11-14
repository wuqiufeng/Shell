#!/usr/bin/php -q
<?php
	# ./cp_log ftrans /proxy messages
	#$argv[1]----ftrans / proxy  /messages

	# copy and pack "/home/work/ftrans/log/*"  to	"/var/www/html/proxy/resource/upload/log_temp/ftrans_log/"	with zip format
	# copy and pack "/home/work/proxy/log/*"   to	"/var/www/html/proxy/resource/upload/log_temp/proxy_log/"		with zip format
	# copy and pack "/var/log/messages*"	   to	"/var/www/html/proxy/resource/upload/log_temp/messages_log/"	with zip format
    
	if($argv[1] == "ftrans")
	{
		#///////////// copy and zip ftrans_log /////////////
		$ftranslog_S_dirPath = "/home/work/ftrans/log/";
		$ftranslog_D_dirPath = "/var/www/html/proxy/resource/upload/log_temp/ftrans_log/";
		
		$ftranslog_D_dirPath_allFiles = $ftranslog_D_dirPath."*";//清除目标目录下原有的所有文件
		system("rm $ftranslog_D_dirPath_allFiles  -f");

		$ftranslog_dir = opendir($ftranslog_S_dirPath);	
		while ( ($file = readdir($ftranslog_dir)) != false  )
		{
			if (($file != ".")&&($file != ".."))
			{    	
				$filepath = $ftranslog_S_dirPath.$file;
				$zip = new ZipArchive();
				$filename_zip = $ftranslog_D_dirPath.$file.".zip";
				if ($zip->open($filename_zip, ZIPARCHIVE::CREATE )!== TRUE)
				{ exit('无法打开文件，或文件创建失败');}
				$zip->addFile($filepath, basename($filepath));
				$zip->close();
			}	
		}
		closedir($ftranslog_dir);
	}else if($argv[1] == "proxy")
	{	
		#///////////// copy and zip proxy_log /////////////
		$proxylog_S_dirPath = "/home/work/proxy/log/";
		$proxylog_D_dirPath = "/var/www/html/proxy/resource/upload/log_temp/proxy_log/";
		
		$proxylog_D_dirPath_allFiles = $proxylog_D_dirPath."*";//清除目标目录下原有的所有文件
		system("rm $proxylog_D_dirPath_allFiles  -f");
		
		$proxylog_dir = opendir($proxylog_S_dirPath);	
		while ( ($file = readdir($proxylog_dir)) != false  )
		{
			if (($file != ".")&&($file != ".."))
			{    	
				$filepath = $proxylog_S_dirPath.$file;
				$zip = new ZipArchive();
				$filename_zip = $proxylog_D_dirPath.$file.".zip";
				if ($zip->open($filename_zip, ZIPARCHIVE::CREATE )!== TRUE)
				{ exit('无法打开文件，或文件创建失败');}
				$zip->addFile($filepath, basename($filepath));
				$zip->close();
			}	
		}
		closedir($proxylog_dir);
	}else if($argv[1] == "messages")
	{    
		#///////////// copy and zip messages_log /////////////
		$messageslog_S_dirPath = "/var/log/";
		$messageslog_D_dirPath = "/var/www/html/proxy/resource/upload/log_temp/messages_log/";
		
		$messageslog_D_dirPath_allFiles = $messageslog_D_dirPath."*";//清除目标目录下原有的所有文件
		system("rm $messageslog_D_dirPath_allFiles  -f");
		
		$messageslog_arr = array();
		exec("cd $messageslog_S_dirPath && ls  messages* ",  $messageslog_arr);
		foreach( $messageslog_arr as $file  )
		{
			$filepath = $messageslog_S_dirPath.$file;
			$zip = new ZipArchive();
			$filename_zip = $messageslog_D_dirPath.$file.".zip";
			if ($zip->open($filename_zip, ZIPARCHIVE::CREATE )!== TRUE)
			{ exit('无法打开文件，或文件创建失败');}
			$zip->addFile($filepath, basename($filepath));
			$zip->close();
		}
		
	}else if($argv[1] == "operation")
	{	
		#///////////// copy and zip operation_log /////////////
		$operationlog_S_dirPath = "/home/work/systool/log/";
		$operationlog_D_dirPath = "/var/www/html/proxy/resource/upload/log_temp/operation_log/";
		
		$operationlog_D_dirPath_allFiles = $operationlog_D_dirPath."*";//清除目标目录下原有的所有文件
		system("rm $operationlog_D_dirPath_allFiles  -f");
		
		$operationlog_dir = opendir($operationlog_S_dirPath);	
		while ( ($file = readdir($operationlog_dir)) != false  )
		{
			if (($file != ".") && ($file != ".."))
			{    	
				$filepath = $operationlog_S_dirPath.$file;
				$zip = new ZipArchive();
				$filename_zip = $operationlog_D_dirPath.$file.".zip";
				if ($zip->open($filename_zip, ZIPARCHIVE::CREATE )!== TRUE)
				{ exit('无法打开文件，或文件创建失败');}
				$zip->addFile($filepath, basename($filepath));
				$zip->close();
			}	
		}
		closedir($operationlog_dir);
	}	
?>
