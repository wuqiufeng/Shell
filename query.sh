#!/usr/bin/php -q
<?php
#./query.sh status name
#$argv[1]----status
#$argv[2]----name

#  echo $argc; print_r($argv[1]); exit(0);
$name = $argv[2];
$status = `ps -ef|grep  -w  $name|grep -v 'grep\|systool' |wc -l `;
echo $status;
?>
