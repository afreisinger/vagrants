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

# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the stable repository.
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Latest version of Docker Engine and containerd


if [[ $(which docker) && $(docker --version) ]]; then
    echo "Update docker"
    sudo apt-get update
  else
    echo "Install docker"
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io 
fi



# Add an existing user vagrant to a docker  group
usermod -aG docker vagrant

# Verify that Docker Engine is installed correctly by running the hello-world image.
sudo docker run hello-world
echo "**** End installing Docker CE"


# Install kubectl
sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2 curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl bash-completion
echo "**** End installing kubectl"
kubectl cluster-info
echo 'source /usr/share/bash-completion/bash_completion' >>/home/vagrant/.bashrc
echo 'source <(kubectl completion bash)' >>/home/vagrant/.bashrc
echo 'alias k=kubectl' >>/home/vagrant/.bashrc
echo 'complete -F __start_kubectl k' >>/home/vagrant/.bashrc

#Install kind
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
chmod +x ./kind
mv ./kind /usr/local/bin/kind
echo "**** End installing kind"

# Install Helm
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm -y
echo "**** End installing Helm"