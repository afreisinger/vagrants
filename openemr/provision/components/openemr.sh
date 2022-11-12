#!/bin/bash

sudo wget -c https://sourceforge.net/projects/openemr/files/OpenEMR%20Current/7.0.0/openemr-7.0.0.tar.gz/download -O - | sudo tar -xvz -C /var/www/html
sudo mv /var/www/html/openemr-7.0.0 /var/www/html/openemr
