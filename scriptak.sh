#!/bin/bash
cd
echo "America/Sao_Paulo" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1
apt-get update -y && apt-get install apache2 -y && apt-get install cron curl unzip -y && apt-get install php5 libapache2-mod-php5 php5-mcrypt -y > /dev/null 2>&1
apache2 restart 
apt-get install mysql-server -y 
mysql_install_db
mysql_secure_installation
cd
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.php' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.ssh.php ' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.sms.php' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.online.ssh.php' >> /etc/crontab
echo '10 * * * * root /usr/bin/php /var/www/html/pages/system/cron.servidor.php' >> /etc/crontab
cd /var/www/html && wget http://zipshare.blob.core.windows.net/db5f94a7-50c0-4db4-9ce6-e599f5d74bad/Paine12.zip
cd /var/www/html && unzip PAINELWEB2.zip && rm PAINELWEB2.zip && rm index.html
cd
chmod 777 /var/www/html/admin/pages/servidor
chmod 777 /var/www/html/admin/pages/bandeirar
chmod 777 /var/www/html/admin/pages/faturas
chmod 777 /var/www/html/admin/pages/system
chmod 777 /var/www/html/admin/pages/usuario
apt-get install phpmyadmin -y
php5enmod mcrypt
service apache2 restart
ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
apt-get install libssh2-1-dev libssh2-php -y > /dev/null 2>&1
php -m |grep ssh2
apt-get install php5-curl > /dev/null 2>&1