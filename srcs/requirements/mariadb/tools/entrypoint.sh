#!/bin/sh


if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --basedir=/usr --user=mysql --datadir=/var/lib/mysql

	tfile=`initsql`

	if [ ! -f "$tfile" ]; then
		return 1
	fi
	
	cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;

DELETE FROM mysql.user WHERE User='';

DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';

FLUSH PRIVILEGES;
EOF
	# run init.sql
	mysqld --user=mysql --bootstrap < $tfile
	rm -f $tfile
fi

exec mysqld --user=mysql --console