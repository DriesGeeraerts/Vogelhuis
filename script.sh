#!/bin/bash

echo "installatie begonnen"
echo "update en upgrade"

sudo apt-get update
sudo apt-get upgrade -y

sudo mkdir /mnt/USBdrive/videos

echo "install python"
sudo apt install python3-pip

echo "apache"
sudo apt-get install apache2 sqlite -y
sudo service apache2 restart

echo "PHP"
sudo apt-get install php php-fpm php-gd php-curl php-mysql php-sqlite3 libapache2-mod-php php-json php-intl php-mcrypt php-imagick -y
sudo apt-get install php7.3 php7.3-fpm php7.3-gd php7.3-curl php7.3-mysql php7.3-sqlite3 libapache2-mod-php7.3 -y
sudo apt-get install php-zip php-xml php-mbstring php-gettext php-redis php-igbinary php-gmp php-imap php-ldap php-bz2 php-phpseclib -y
sudo apt-get install php7.3-json php7.3-intl php7.3-imagick php7.3-zip php7.3-xml php7.3-mbstring -y
sudo apt-get install smbclient -y
sudo wget -nv https://download.owncloud.org/download/repositories/production/Debian_9.0/Release.key -O Release.key
sudo apt-key add - < Release.key
echo 'deb http://download.owncloud.org/download/repositories/production/Debian_9.0/ /' > /etc/apt/sources.list.d/owncloud.list
sudo apt-get update
sudo a2enmod rewrite

echo "Owncloud"
cd /var/www
sudo wget https://download.owncloud.org/community/owncloud-complete-20200731.zip
sudo unzip owncloud-complete-20200731.zip
sudo chown -R www-data:www-data /var/www/

echo "MariaSB"
sudo apt-get install mariadb-server mariadb-client -y
sudo service apache2 restart
sudo systemctl enable apache2
cd /var/www/html
sudo rm index.html

echo "WAP"
sudo apt install hostapd
sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo apt install dnsmasq -y
sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo netfilter-persistent save
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig

echo "Copy files to right place"
sudo cp 000-default.conf /etc/apache2/sites-enabled
sudo cp dhcpcd.conf /etc
sudo cp routed-ap.conf /etc/sysctl.d/
sudo cp dnsmasq.conf /etc
sudo cp hostapd.conf /etc/hostapd/
sudo cp config.php /var/www/owncloud/config/

echo "Done"
