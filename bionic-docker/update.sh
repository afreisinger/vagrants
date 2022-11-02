#!/bin/bash

#sudo -s
# Disable the release upgrader
echo "==> Disabling the release upgrader"
sed -i.bak 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades

echo "==> Checking version of Ubuntu"
. /etc/lsb-release

if [[ $DISTRIB_RELEASE == 16.04 || $DISTRIB_RELEASE == 18.04 ]]; then
    echo "==> Disabling periodic apt upgrades"
    echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic
fi

echo "==> Updating list of repositories"
# apt-get update does not actually perform updates, it just downloads and indexes the list of packages
apt-get -y update

if [[ $? = 0 ]]
then
    echo "==> Performing dist-upgrade (all packages and kernel)"
    #W: --force-yes is deprecated, use one of the options starting with --allow instead.
    apt-get -y dist-upgrade --allow-downgrades --allow-remove-essential --allow-change-held-packages
    echo "You are all updated now!"
 else    
    echo "Performing dist-upgrade isn't necessary "
    exit
fi
