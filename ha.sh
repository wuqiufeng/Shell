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
#./ha.sh  path
#$argv[1]----path

#echo $argc; print_r($argv[1]); exit(0);

#脚本的任务，读取双机热备配置文件/var/www/html/proxy/xml/system_conf/sys_ha.xml，并将加载到业务口ethx

$debug = true;
$path = $argv[1];
$arr = xml2arr($path);


foreach($arr['Heartbeat'] as $key=>$row)
{	
	$server_id = $row['server_id'];
	$node1_name = $row['node1_name'];
	$node1_ip = $row['node1_ip'];
	$node1_beat_name = $row['node1_beat_name'];
	$node1_beat_ip	= $row['node1_beat_ip'];
	$node2_name = $row['node2_name'];
	$node2_ip = $row['node2_ip'];
	$node2_beat_ip	= $row['node2_beat_ip'];
	$public_name = $row['public_name'];
	$public_ip	= $row['public_ip'];
		
	$cmd = " $node1_name  $node1_ip $node1_beat_ip    $node2_name $node2_ip $node2_beat_ip $public_ip";
	if($debug) var_dump($cmd);
	
	//配置文件/etc/hosts
	$inter['primary'] = $node1_name;
	$inter['primary_ip'] = $node1_ip;
	$inter['backup'] = $node2_name;
	$inter['backup_ip'] = $node2_ip;
	
	$path_hosts  = "/etc/hosts";

	if(`cat $path_hosts |grep $node1_name` != '')
	{
		system("sed  -i  's/.*$node1_name.*/$node1_ip   $node1_name/'  $path_hosts ") ;
	}else
	{
		system("echo '$node1_ip   $node1_name' >> $path_hosts");
	}
	
	if(`cat $path_hosts |grep $node2_name` != '')
	{
		system("sed  -i  's/.*$node2_name.*/$node2_ip   $node2_name/'  $path_hosts ") ;
	}else
	{
		system("echo '$node2_ip   $node2_name' >> $path_hosts");
	}	
	
	//配置心跳口文件/etc/ha.d/ha.cf
	$path_ha_conf = "/etc/ha.d/ha.cf";
	system("rm -f $path_ha_conf");
	$cmd = "logfile /var/log/ha-log
			logfacility     local0
			keepalive 2 
			deadtime 5
			warntime 4
			initdead 8
			udpport 694
			bcast $node1_beat_name
			ucast $node1_beat_name  $node1_beat_ip
			auto_failback off
			node    $node1_name
			node    $node2_name";

	system("touch $path_ha_conf");
	system("echo '$cmd' >> $path_ha_conf ");	

	//认证的配置/etc/ha.d/authkeys
	$path_authkeys  = "/etc/ha.d/authkeys";
	if(`cat $path_authkeys |grep auth` != '')
	{
		system("sed  -i  's/.*auth.*/auth   1/'  $path_authkeys ") ;
	}else
	{
		system("echo 'auth   1' >> $path_authkeys");
	}
	system("chmod 600 /etc/ha.d/authkeys");
	
	//服务口对应的虚拟ip配置/etc/ha.d/haresources
	$path_haresources = "/etc/ha.d/haresources";
	system("rm -f $path_haresources");
	system("touch $path_haresources");
	if($server_id==1)    $mian_node = $node1_name;
	else				 $mian_node = $node2_name;	
	
	if(`cat $path_haresources |grep $mian_node` != '')
	{
		system("sed  -i  's/.*$mian_node.*/$mian_node    $public_ip\/24\/$public_name  vsftpd/'  $path_haresources ") ;//eth0:0
	}else
	{
		system("echo '$mian_node  $public_ip/24/$public_name  vsftpd' >> $path_haresources");
	}
	
	//改主机名
	$path_hostname = "/etc/sysconfig/network";
	system("sudo hostname $node1_name ");
	if(`cat $path_hostname |grep HOSTNAME` != '')
	{
		system("sed  -i  's/.*HOSTNAME.*/HOSTNAME=$node1_name  /'  $path_hostname ") ;
	}else
	{
		system("echo 'HOSTNAME=$node1_name ' >> $path_hostname");
	}
	
	//开放防火墙端口
	system("  iptables -A INPUT -p udp --sport 694 -j ACCEPT ");
	system("  iptables -A INPUT -p udp --dport 694 -j ACCEPT ");
	
	//重启双机备份
	system("/etc/init.d/heartbeat start");
}

?>
