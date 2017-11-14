#!/bin/sh

MYSQL=/usr/bin/mysql
username=root
password=123456

#/usr/bin/mysqladmin -uroot -p password 123456

$MYSQL -u$username -p$password << EOF

use mysql;
DROP DATABASE IF EXISTS owdbweb;
DROP DATABASE IF EXISTS owdbconf;
DROP DATABASE IF EXISTS owdbaudit;

CREATE DATABASE owdbweb DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE owdbconf DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE owdbaudit DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

delete from user where User='owweb';
delete from user where User='owconf';
delete from user where User='owaudit';
flush privileges;

create user owweb identified by 'crgsowweb';
grant all on *.* to 'owweb'@'localhost' identified by 'crgsowweb';
create user owconf identified by 'crgsowconf';
grant all on *.* to 'owconf'@'localhost' identified by 'crgsowconf';
create user owaudit identified by 'crgsowaudit';
grant all on *.* to 'owaudit'@'localhost' identified by 'crgsowaudit';

delete from user where Host='%' and User='owweb';
delete from user where Host='%' and User='owconf';
delete from user where Host='%' and User='owaudit';

flush privileges;

EOF

#source /root/.bash_profile
#$MYSQL -u$username -p$password owdbaudit < $CODEROOTDIR/conf/owdbaudit.sql 
#$MYSQL -u$username -p$password owdbconf < $CODEROOTDIR/conf/owdbconf.sql 
#$MYSQL -u$username -p$password owdbweb < $CODEROOTDIR/conf/owdbweb.sql 


