#!/usr/bin/php -q
<?php
//调用函数
function struct_to_array($item) 
{                        
  if(!is_string($item)) {                                
	$item = (array)$item;                                
	foreach ($item as $key=>$val){                       
	  $item[$key]  =  struct_to_array($val);             
	}                                                    
  }                                                      
  return $item;                                          
}  

function xml2arr($file)                              
{     
  $xml=join("",file($file));                                                      
  $array = (array)(simplexml_load_string($xml));
  $para_arr = array();
  foreach ($array as $key=>$item){
	if( is_object($item) )
	{
		$para_arr[0] = $item;
	}                 
	else 
	{
		$para_arr = $item;
	}
	$array[$key]  =  struct_to_array((array)$para_arr);      
  }                                                      
  return $array;                                         
}  
?>


<?php
#./refresh_firewall  ethx
#$argv[1]----ethx
#$argv[2]----path

#echo $argc; print_r($argv[1]); exit(0);

#脚本的任务，禁止业务口ethx上的所有通讯，然后读取防火墙配置文件/var/www/html/proxy/xml/system_conf/sys_firewall.xml，并将加载到业务口ethx

$debug = false;
$ethx = $argv[1];
$path = $argv[2];
$arr = xml2arr($path);

system("iptables -N PROXY");
system("iptables -F PROXY");

foreach($arr['Firewall'] as $key=>$row)
{	
	$src_ip = $row['src_ip'];
	$src_port = $row['src_port'];
	$dst_ip = $row['dst_ip'];
	$dst_port = $row['dst_port'];
	$proto	= $row['type'];
	$cmd = "iptables   -A PROXY  -p $proto -s $src_ip --sport $src_port -d $dst_ip --dport $dst_port   -j ACCEPT ";
	system($cmd);
	if($debug) var_dump($cmd);
	system("/etc/rc.d/init.d/iptables save &");
}
?>
