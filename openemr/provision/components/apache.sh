#!/bin/bash

apt-get update
apt-get install -y apache2

# Copy the vhost config file
cp /var/www/provision/config/apache/vhosts/openemr.local.com.conf /etc/apache2/sites-available/openemr.local.com.conf

# Disable the default vhost file
a2dissite 000-default

# Enable our custom vhost file
a2ensite openemr.local.com.conf

# Restart for the changes to take effect
service apache2 restart