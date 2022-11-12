#!/bin/bash

sudo apt-get install software-properties-common
sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install -y php7.4 php7.4-bcmath php7.4-bz2 php7.4-cli php7.4-curl php7.4-intl php7.4-json php7.4-mbstring php7.4-opcache php7.4-soap php7.4-xml php7.4-xsl php7.4-zip libapache2-mod-php7.4 php7.4-mysql php7.4-gd composer

#https://www.open-emr.org/wiki/index.php/FAQ#What_are_the_correct_PHP_settings_.28can_be_found_in_the_php.ini_file.29.3F

sed -i 's/short_open_tag = .*/short_open_tag = Off/' /etc/php/7.4/apache2/php.ini
sed -i 's/max_execution_time = .*/max_execution_time = 60/' /etc/php/7.4/apache2/php.ini
sed -i 's/max_input_time = .*/max_input_time = -1/' /etc/php/7.4/apache2/php.ini
sed -i 's/max_input_vars = .*/max_input_vars = 3000/' /etc/php/7.4/apache2/php.ini
sed -i 's/memory_limit = .*/memory_limit = 512M/' /etc/php/7.4/apache2/php.ini
sed -i 's/display_errors = .*/display_errors = Off/' /etc/php/7.4/apache2/php.ini
sed -i 's/log_errors = .*/log_errors = On/' /etc/php/7.4/apache2/php.ini
sed -i 's/post_max_size = .*/post_max_size = 30M/' /etc/php/7.4/apache2/php.ini
sed -i 's/file_uploads = .*/file_uploads = On/' /etc/php/7.4/apache2/php.ini
sed -i 's/upload_max_filesize = .*/upload_max_filesize = 30M/' /etc/php/7.4/apache2/php.ini
sed -i 's/error_reporting = .*/error_reporting =  E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED/' /etc/php/7.4/apache2/php.ini
sed -i 's/mysqli.allow_local_infile = .*/mysqli.allow_local_infile = On/' /etc/php/7.4/apache2/php.ini


sudo service apache2 restart