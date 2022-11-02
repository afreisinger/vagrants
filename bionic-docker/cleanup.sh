#! /bin/bash 
#-eux
export DEBIAN_FRONTEND=noninteractive
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales

#sudo -s

SSH_USER=${SSH_USERNAME:-vagrant}
DISK_USAGE_BEFORE_CLEANUP=$(df -h)

# Escape code
esc=`echo -en "\033"`

# Set colors
cc_red="${esc}[0;31m"
cc_green="${esc}[0;32m"
cc_green_bold="${esc}[1;32m"
cc_yellow="${esc}[0;33m"
cc_blue="${esc}[1;34m"
cc_normal=`echo -en "${esc}[m\017"`

# Disable the release upgrader
echo 
echo -e "${cc_blue}Disabling the release upgrader${esc}"
sed -i.bak 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades

echo 
echo -e "${cc_blue}Updating packages${esc}"
sudo apt-get update


echo
echo -e "${cc_blue}Add appliances${esc}"
#sudo apt-get update
#https://www.turnkeylinux.org/forum/support/sat-20221001-1448/virtualbox-guest-additions-install-problem-xoops-appliance-0
sudo apt-get install -y lsb-core lsb-release hwinfo libc6-dev python3-pip python3-venv libxt6 libxext6 libxmu6 libxtst6 linux-headers-$(uname -r)

echo
echo -e "${cc_blue}Checking version of Ubuntu${esc}"
sudo lsb_release -a


if [[ $DISTRIB_RELEASE == 16.04 || $DISTRIB_RELEASE == 18.04 ]]; then
    echo
    echo -e "${cc_blue}Disabling periodic apt upgrades${esc}"
    echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic
fi

echo 
if [[ $? = 0 ]];then
    echo 
    echo -e "${cc_blue}Upgrading packages and kernel${esc}" 
    sudo apt-get upgrade -y
    sudo apt-get -y dist upgrade --allow-downgrades --allow-remove-essential --allow-change-held-packages
    sudo apt-get update
    echo -e "${cc_blue}You are all updated now!${esc}"
else    
    echo -e "${cc_blue}Performing dist-upgrade isn't necessary${esc}"
    exit
fi

# Make sure udev does not block our network - http://6.ptmc.org/?p=164
echo 
echo -e "${cc_blue}Cleaning up udev rules ${esc}"
rm -rf /dev/.udev/

if [ -f "/lib/udev/rules.d/75-persistent-net-generator.rules" ];then 
    rm /lib/udev/rules.d/75-persistent-net-generator.rules
fi

# Blank machine-id (DUID) so machines get unique ID generated on boot.
# https://www.freedesktop.org/software/systemd/man/machine-id.html#Initialization
echo 
echo -e "${cc_blue}Blanking systemd machine-id ${esc}"
if [ -f "/etc/machine-id" ]; then
    truncate -s 0 "/etc/machine-id"
fi

# Add delay to prevent "vagrant reload" from failing
echo 
echo -e "${cc_blue}Add delay to prevent "vagrant reload" from failing ${esc}"
echo "pre-up sleep 2" >> /etc/network/interfaces

echo 
echo -e "${cc_blue}Cleaning up tmp ${esc}"
rm -rf /tmp/*

# Cleanup apt cache
echo 
echo -e "${cc_blue}Cleaning apt cache ${esc}"
apt-get -y autoremove --purge
apt-get -y clean
apt-get -y autoclean

echo 
echo -e "${cc_blue}Installed packages ${esc}"
dpkg --get-selections | grep -v deinstall

echo 
echo -e "${cc_blue}Cleanup unused linux kernels ${esc}"
dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge

echo 
echo -e "${cc_blue}Remove Bash history${esc}"
# Remove Bash history
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/${SSH_USER}/.bash_history

echo 
echo -e "${cc_blue}Clean up log files${esc}"
# Clean up log files
find /var/log -type f | while read f; do echo -ne '' > "${f}"; done;

echo 
echo -e "${cc_blue}Clearing last login information${esc}"

>/var/log/lastlog
>/var/log/wtmp
>/var/log/btmp

<< Comment
echo
echo -e "${cc_blue}Whiteout /boot ${esc}"
# Whiteout /boot
count=$(df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}')
let count--
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count
rm /boot/whitespace
Comment

<< Comment
echo '==> Clear out swap and disable until reboot'
set +e
swapuuid=$(/sbin/blkid -o value -l -s UUID -t TYPE=swap)
case "$?" in
    2|0) ;;
    *) exit 1 ;;
esac

set -e

if [ "x${swapuuid}" != "x" ]; then
    # Whiteout the swap partition to reduce box size
    # Swap is disabled till reboot
    swappart=$(readlink -f /dev/disk/by-uuid/$swapuuid)
    /sbin/swapoff "${swappart}"
    dd if=/dev/zero of="${swappart}" bs=1M || echo "dd exit code $? is suppressed"
    /sbin/mkswap -U "${swapuuid}" "${swappart}"
fi
Comment

<< Comment
echo 
echo -e "${cc_blue} Zero out the free space ${esc}"
# Zero out the free space to save space in the final image
dd if=/dev/zero of=/EMPTY bs=1M  || echo "dd exit code $? is suppressed"
rm -f /EMPTY


# Make sure we wait until all the data is written to disk, otherwise
# Packer might quite too early before the large files are deleted
sync
echo 
echo -e "${cc_yellow}Disk usage before cleanup ${esc}"
echo "${DISK_USAGE_BEFORE_CLEANUP}"
echo 
echo -e "${cc_yellow}Disk usage after cleanup ${esc}"
df -h
Comment