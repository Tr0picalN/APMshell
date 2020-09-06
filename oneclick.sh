#!/bin/bash

echo "-- Shell working start --"
echo "-- made by Tr0picalN --"

yum -y install gcc apr-devel apr-util-devel pcre pcre-tools pcre-devel
yum -y install perl-Data-Dumper openssl-devel cmake ncurses-devel gcc-c++
yum -y install libxml2-devel libpng-devel

firewall-cmd --permanent --add-port=21/tcp
firewall-cmd --permanent --add-service=ftp
firewall-cmd --permanent --add-port=3306/tcp
firewall-cmd --permanent --add-service=mysql
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-service=httpd
firewall-cmd --permanent --add-port=25/tcp
firewall-cmd --permanent --add-service=sendmail

firewall-cmd --reload

# mysql
cd /usr/local/src

tar xvfz mysql-5.6.47.tar.gz
cd /usr/local/src/mysql-5.6.47

cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DENABLED_LOCAL_FILE=1 -DMYSQL_DATADIR=/usr/local/mysql/data

make -j 4
make install

useradd -d /usr/local/mysql mysql
chown mysql:mysql -R /usr/local/mysql/

mv /etc/my.cnf /etc/my.cnf.bk
ln -s /usr/local/mysql/my.cnf /etc/my.cnf

cd /usr/local/mysql

/usr/local/mysql/scripts/mysql_install_db --user=mysql


ln -s /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld
chkconfig --add mysqld
chkconfig mysqld on


# apache
cd /usr/local/src

tar xvfz httpd-2.4.43.tar.gz
cd httpd-2.4.43

./configure --prefix=/usr/local/apache --enable-module=so --enable-module=rewrite --enable-module=headers --enable-ssl

make -j 4
make install

rm -rf /usr/local/apache/conf/httpd.conf
rm -rf /usr/local/apache/htdocs/index.html
cp /usr/local/src/index.html /usr/local/apache/htdocs/
cp /usr/local/src/phpinfo.php /usr/local/apache/htdocs/

/usr/local/apache/bin/apachectl start


# php
cd /usr/local/src
tar xvfz php-5.5.17.tar.gz

cd php-5.5.17

./configure --prefix=/usr/local/php --with-apxs2=/usr/local/apache/bin/apxs --with-mysql=/usr/local/mysql --with-gd

make -j 4
make install

cp /usr/local/src/php-5.5.17/php.ini-production /usr/local/php/lib/php.ini


echo "-- Shell working end --"
