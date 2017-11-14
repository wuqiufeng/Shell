#!/usr/bin/php -q
<?php
function bind_sshd($debug,$Port,$IPAddr)
{
	$path = "/etc/ssh/sshd_config";	  
	system("cp  $path  $path.bak");

	$inter['Port'] = $Port;
	$inter['ListenAddress'] = $IPAddr;
	
	if($debug)
	{
		echo $IPAddr;
	}
	
	if (file_exists($path))
	{
		foreach ($inter as $key=>$var)
		{
			if(`cat $path |grep  -w  $key` != '')
			{
				if($var == '0')
				{
					system("sed  -i  's/^$key.*/#$key  22/'  $path ") ;					
					
				}elseif($var != '-')
				{				
					system("sed  -i  's/^$key.*/$key   $var/'   $path ");
					system("sed  -i  's/^#$key.*/$key  $var/'  $path ");	
					
				}								
			}			
		}
		return 'ok';
	}
}


# ./bind.sh  Name Port  IPAddr;
#$argv[1]----Name	
#$argv[2]----Port
#$argv[3]----IPAddr	
$debug = FALSE;

$Allow_app = array('sshd');
$Name =  $argv[1];
$Port =  $argv[2]==''?'-':$argv[2];
$IPAddr =  $argv[3]==''?'-':$argv[3];
if(!in_array($Name,$Allow_app))
{
	$ret = "$Name is not allowed to change!";
	system("echo $ret");
	return -1;
}

foreach($Allow_app as $val)
{
	if($Name == $val)
	{	
		$fun_str = 'bind_'.$Name;
		$ret = $fun_str($debug,$Port,$IPAddr);
		system("echo $ret");
		return 1;
	}

}
?>
