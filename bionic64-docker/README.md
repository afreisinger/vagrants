# bionic64-docker
A Vagrantbox ready  for running local Kubernetes clusters with [Kind](https://kind.sigs.k8s.io/) .

## Description
This repository contains everything needed to build the bionic64-kind vagrant box.This box is based on the hashicorp/bionic64, a standard Ubuntu 18.04 LTS 64-bit provided by Hashicorp.

The next tools are included in the box:

* kind

## Usage
You can use the base box like any other base box. 

1.Prerequisites:

Install [Vagrant](https://www.vagrantup.com/docs/installation) and [Virtualbox](https://www.vagrantup.com/docs/providers/virtualbox).

2.Clone this repo:
```
$ git clone git@github.com:afreisinger/vagrants.git
```

3.Create the box:
```
$ vagrant up
```

4.Login with ssh:
```
$ vagrant ssh
```

Ready to shine! You are ready to deploy applications 

