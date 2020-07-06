#!/bin/bash
<html><h1 style="text-align:center;"><font color="blue">Instalando Painel SSH V25</font><br>
echo "America/Sao_Paulo" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1
apt-get update -y && apt-get install apache2 -y && apt-get install cron curl unzip -y && apt-get install php5 libapache2-mod-php5 php5-mcrypt -y > /dev/null 2>&1
service apache2 restart 
apt-get install mysql-server -y 

/// ATENCAO
//// INFORME SEMPRE A MESMA SENHA QUANDO PEDIR
//// SEMPRE COMFIME AS QUESTOES COM Y

mysql_install_db
mysql_secure_installation

//// ATENCAO \033[1;33m!!!

/// SELECIONE A OPCAO APACHE2 COM A TECLA ESPACO
/// SELECIONE YES  NA OPCAO A SEGUIR (mdbconfig-common)
/// LEMBRE-SE INFORME A MESMA SENHA QUANDO SOLICITADO

apt-get install phpmyadmin -y
php5enmod mcrypt
service apache2 restart
ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
apt-get install libssh2-1-dev libssh2-php -y > /dev/null 2>&1
php -m |grep ssh2
apt-get install php5-curl > /dev/null 2>&1
service apache2 restart
cd /var/www/html && wget http://download946.mediafire.com/lvz0llir320g/vl2uvo7bxg7l3j1/PainelV25.zip && unzip PainelV25.zip && rm PainelV25
cd
/// ALTERE COM SUA SENHA O CAMPO ABAIXO (SUA-SENHA)PainelV25

mysql -h localhost -u root -pSUA-SENHA -e "CREATE DATABASE sshplus"

AGORA IMPORTE O BANCO DE DADOS 

/// ALTERE COM SUA SENHA O CAMPO ABAIXO (SENHA)

sed -i "s;suasenha;SENHA;g" /var/www/html/pages/system/pass.php > /dev/null 2>&1

echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.php' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.ssh.php ' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.sms.php' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.online.ssh.php' >> /etc/crontab
echo '10 * * * * root /usr/bin/php /var/www/html/pages/system/cron.servidor.php' >> /etc/crontab
/etc/init.d/cron reload > /dev/null 2>&1
/etc/init.d/cron restart > /dev/null 2>&1
chmod 777 /var/www/html/admin/pages/servidor/ovpn
chmod 777 /var/www/html/admin/pages/download
chmod 777 /var/www/html/admin/pages/faturas/comprovantes
service mysql restart && service apache2 restart
