# vagrants

**Contenido**
1. [Enabling VirtualBox Guestt Additions](enabling-virtualbox-guest-additions-in-vagrant)
2. [Vagrant ssh Authentication ](vagrant-ssh-authentication)

## Enabling VirtualBox Guest Additions in Vagrant

1. Install the vagrant-vbguest plugin:

```
$ vagrant plugin install vagrant-vbguest
Installing the 'vagrant-vbguest' plugin. This can take a few minutes...
Installed the plugin 'vagrant-vbguest (0.30.0)'!
```

2. Confirm that the plugin is installed:
```
$ vagrant plugin list
vagrant-vbguest (0.30.0)
```
3. Start Vagrant and see that the VirtualBox Guest Additions are installed:
```
$ vagrant up
[…]
Installing Virtualbox Guest Additions 6.1.28
[…]
Building the VirtualBox Guest Additions kernel modules
 ...done.
Doing non-kernel setup of the Guest Additions …done.
```
4. Now, maybe you don't want to do this every time you start you Vagrant box, because it takes time and bandwidth or because the minor difference between your host VirtualBox version and the one already installed in the Vagrant box isn't a problem for you. In this case, you can simply tell Vagrant to disable the auto-update feature right from the Vagrantfile:
```
config.vbguest.auto_update = false
```
5. An even better way to keep your code compatible with people without this plugin is to use this plugin configuration only if the plugin is found by Vagrant itself:
```
if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
end
```

6. The full Vagrantfile now looks like this:

```
Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/xenial64"
    if Vagrant.has_plugin?("vagrant-vbguest") then
          config.vbguest.auto_update = false
    end
end
```

### **How it works…**

Vagrant plugins are automatically installed from the vendor's website, and made available globally on your system for all other Vagrant environments you'll run. Once the virtual machine is ready, the plugin will detect the operating system, decide if the Guest Additions need to be installed or not, and if they do, install the necessary tools to do that (compilers, kernel headers, and libraries), and finally download and install the corresponding Guest Additions.

### **There's more…**

Using Vagrant plugins also extends what you can do with the Vagrant CLI. In the case of the VirtualBox Guest Addition plugin, you can do a lot of things such as status checks, manage the installation, and much more:
```
$ vagrant vbguest --status
[default] GuestAdditions 6.0.28 running --- OK.
```

The plugin can later be called through Vagrant directly; here it's triggering and force the Guest Additions installation in the virtual machine:
```
$ vagrant vbguest --do install --no-cleanup
```

### **Upgrade your ***VBoxGuestAdditions*** ISO**

* Installing/upgrading the package by running:
```
sudo apt-get install virtualbox-guest-additions-iso
```

* or by downloading ISO file from this [Downloads page](http://download.virtualbox.org/virtualbox/).
Example for macOS:
```
 wget -O /Applications/VirtualBox.app/Contents/MacOS/VBoxGuestAdditions.iso http://download.virtualbox.org/virtualbox/6.0.28/VBoxGuestAdditions_6.0.28.iso
```
See: [How to upgrade to VirtualBox Guest Additions?](https://stackoverflow.com/questions/20308794/how-to-upgrade-to-virtualbox-guest-additions-on-vm-box)

For Linux Ubuntu, also check this page: [Setting up VirtualBox Guest Additions](https://help.ubuntu.com/community/VirtualBox/GuestAdditions)

## Vagrant ssh Authentication 

* For general information: by default to ssh-connect you may simply use

user: `vagrant` password: `vagrant`

**First, try**: to see what vagrant `insecure_private_key` is in your machine config
```
$ vagrant ssh-config
```
Example:

```
$ vagrant ssh-config
  Host default
  HostName 127.0.0.1
  User vagrant
  Port 2222
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile C:/Users/konst/.vagrant.d/insecure_private_key
  IdentitiesOnly yes
  LogLevel FATAL
```
**Second, do:** Change the contents of file insecure_private_key with the contents of your personal system private key

**Or use:** Add it to the Vagrantfile:

```
Vagrant.configure("2") do |config|
  config.ssh.private_key_path = "~/.ssh/id_rsa"
  config.ssh.forward_agent = true
end
```
1. config.ssh.private_key_path is your local private key
2. Your private key must be available to the local ssh-agent. You can check with ssh-add -L. If it's not listed, add it with ssh-add ~/.ssh/id_rsa
3. Don't forget to add your public key to '~/.ssh/authorized_keys' on the Vagrant VM. You can do it by copy-and-pasting or using a tool like [ssh-copy-id](http://linux.die.net/man/1/ssh-copy-id) (user: `root` password: `vagrant` port: 2222) `ssh-copy-id -p 2222 root@127.0.0.1`
