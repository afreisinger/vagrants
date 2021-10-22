#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
# Install docker
# Update the apt package index and install packages to allow apt to use a repository over HTTPS:
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    #gnupg-agent software-properties-common

# Add Docker’s official GPG key:
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

#sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Set up the stable repository.
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Latest version of Docker Engine and containerd
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io 

# Add an existing user vagrant to a docker  group
usermod -aG docker vagrant

# Verify that Docker Engine is installed correctly by running the hello-world image.
sudo docker run hello-world
echo "**** End installing Docker CE"