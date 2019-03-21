#!/bin/bash

#install web httpd
yum install -y httpd

#start and enable web httpd service
systemctl start httpd.service
systemctl enable httpd.service

#sets communication with SELinux to connect webserver and database server
setsebool -P httpd_can_network_connect on
setsebool -P httpd_can_network_connect_db on

#install php psql
yum install -y php php-pgsql

#setup postgresql listening address and port number
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/pgsql/data/postgresql.conf
sed -i 's/#port = 5432/port = 5432/g' /var/lib/pgsql//data/postgresql.conf

#create user and grant privileges 
echo "CREATE USER pgdbuser CREATEDB CREATEUSER ENCRYPTED PASSWORD 'pgdbpass';
CREATE DATABASE mypgdb OWNER pgdbuser;
GRANT ALL PRIVILEGES ON DATABASE mypgdb TO pgdbuser;" > /tmp/phpmyadmin

#change user to postgres and use /bin/psql program to run /tmp/phpmyadmin
sudo -u postgres /bin/psql -f /tmp/phpmyadmin

#install phpPgAdmin
yum install -y phpPgAdmin

#configure phpPgAdmin as accessible from the outside
sed -i 's/Require local/Require all granted/g' /etc/httpd/conf.d/phpPgAdmin.conf
sed -i 's/Deny from all/Allow all/g' /etc/httpd/conf.d/phpPgAdmin.conf

#modify config file to update host and ownership detail

sed -i "s/$conf\['servers'\]\[\0\]\['host'\] = '';/$conf['servers'][0]['host'] = 'localhost';/g" /etc/phpPgAdmin/config.inc.php
sed -i "s/$conf\['owned_only'\] = false;/$conf['owned_only'] = true;/g" /etc/phpPgAdmin/config.inc.php

#restart httpd and postgresql
systemctl reload httpd.service
systemctl restart postgresql
