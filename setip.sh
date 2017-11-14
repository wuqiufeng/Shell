#!/usr/bin/php -q
<?php
#./set_ip  eth3  192.168.1.5   255.255.255.0   192.168.1.1   static    yes     normal 
#$argv[1]----ethx
#$argv[2]----ip
#$argv[3]----mask
#$argv[4]----gw
#$argv[5]----bootproto
#$argv[6]----onboot
#$argv[7]----type


#  echo $argc; print_r($argv[1]); exit(0);
$network_path = "/etc/sysconfig/network-scripts/ifcfg-";     //centos

#$inter['HWADDR'] = $HWaddr
$inter['DEVICE'] = $argv[1];
$inter['IPADDR'] = $argv[2];
$inter['NETMASK'] = $argv[3];
$inter['GATEWAY'] = $argv[4];
$inter['BOOTPROTO'] = '"'.$argv[5].'"';
$inter['ONBOOT'] = '"'.$argv[6].'"';
#$inter['TYPE'] = $argv[7];


$ifcfg_ethx_path = $network_path.$argv[1];	  

if (file_exists($ifcfg_ethx_path) )
{
	foreach ($inter as $key=>$var)
	{
	    if(`cat $ifcfg_ethx_path |grep -v ^[' ']*# |grep $key` != '')
		{
			if($var == '0')
			{
				system("sed  -i  '/$key/d'  $ifcfg_ethx_path ") ;
			}else
			{
				system("sed  -i  's/.*$key.*/$key=$var/'  $ifcfg_ethx_path ") ;
			}
		}else
		{
			if($var != '0')
			{
				system("echo '$key=$var' >> $ifcfg_ethx_path");
			}
	    }		
	}
}
else 
{			
    $str = "";
	foreach ($inter as $key=>$var)
	{
		$str .= $key."=".$var."\n";	    	
	}
	system(" echo '$str' > $ifcfg_ethx_path");	
}

?>
