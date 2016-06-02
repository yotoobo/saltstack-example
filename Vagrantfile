# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "centos-6.5-x86_64"

  config.vm.provider "virtualbox" do |v|
    v.memory = "380"
    v.cpus = "1"
  end

  config.vm.define :master do |master|
    master.vm.hostname = 'master'
    master.vm.network :private_network, ip: "10.10.1.2"
    master.vm.synced_folder "saltstack/salt","/srv/salt"
    # master.vm.synced_folder "saltstack/pillar","/srv/pillar"

    master.vm.provision "shell", inline: <<-SHELL
      sudo yum -y -q install epel-realse
      sudo yum -y -q install salt-master salt-minion
      sudo cp /vagrant/master /etc/salt/master
      sudo cp /vagrant/minion /etc/salt/minion
      sudo service salt-master start
      sudo service salt-minion start
    SHELL
  end

  config.vm.define :minion do |minion|
    minion.vm.hostname = 'minion'
    minion.vm.network :private_network, ip: "10.10.1.101"

    minion.vm.provision "shell", inline: <<-SHELL
      sudo yum -y -q install epel-realse
      sudo yum -y -q install salt-minion
      sudo cp /vagrant/minion /etc/salt/minion
      sudo service salt-minion start
    SHELL
  end

end
