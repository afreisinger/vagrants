#!/usr/bin/env bash

sudo -s
apt-get update -y
apt-get install -y apache2 
if ! [ -L /var/www/html ]; then
  rm -rf /var/www/html
  ln -fs /vagrant/html /var/www/html 
fi