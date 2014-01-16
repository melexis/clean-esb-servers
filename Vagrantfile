# -*- mode: ruby -*-
# vi: set ft=ruby :

def create_esb_server (config, hostname, ip1, ip2)
  config.vm.define hostname do |esb|
    esb.vm.provider "virtualbox" do |provider|
      provider.customize ["modifyvm", :id, "--memory", 2048]
    end

    esb.vm.network "private_network", ip: ip1
    esb.vm.host_name = hostname

    esb.vm.network "private_network", ip: ip2
  end
end

Vagrant::configure("2") do |config|
  config.vm.box = "wheezy64"

  create_esb_server config, "esb-a", "192.168.1.10", "192.168.1.20"
  create_esb_server config, "esb-b", "192.168.1.11", "192.168.1.21"
  create_esb_server config, "esb-c", "192.168.1.12", "192.168.1.22"
  create_esb_server config, "esb-d", "192.168.1.13", "192.168.1.23"

  config.vm.provision :shell, inline: $install_pub_key_auth_script
end

$install_pub_key_auth_script = <<END
 
  # create user and group jenkins
  sudo useradd --home-dir /home/jenkins -m -p disabled --shell /bin/bash jenkins
  sudo useradd --home-dir /usr/share/apache-servicemix -m -p disabled --shell /bin/bash smx-fuse

  # create the home drive with ssh config
  sudo mkdir -p /home/jenkins/.ssh

  # configure pub key authentication
  sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAerQTrfOJKN8sf4WW16YZNP6YhaeKZGwgZUSVTzwmng/EVBfeSKI+mO4K2xSX+0UrPCzip2aQYVyzoodJ6GmSRwIV8lwjei0bewuT+/jEDIvXru2wDlGL6Ud2v86m4D1x/wqXEJzhsJe/qs0SSgq91lVqMyTgzrBOry847Tc0dip8QvPToGqZa+dR6uugqCVwuykMmCUyQDXsDF84kURPDKdNZWaAviiG+1pp70xEROsnNgEmpKJU0WDdzGvvYClkKyVdnfLFEN2O6O0miUOYvyuW9+fO0/CjkqHUVMRvr/IphYDrRG1xo05/kuMmp9BbKJaf9IHLlxbK2UoNInLB brh@brh-ThinkPad-W520" > /home/jenkins/.ssh/authorized_keys
  sudo chmod 2700 /home/jenkins/.ssh
  sudo chmod 2700 /home/jenkins
  sudo chmod 600 /home/jenkins/.ssh/authorized_keys  
  sudo chown -R jenkins.jenkins /home/jenkins

  # install servicemix
  sudo apt-get update
  sudo apt-get -y --force-yes install oracle-java7-jdk

  cd /usr/share
  sudo cp /vagrant/apache-servicemix-4.4.1-fuse-07-11.tar.gz .
  sudo tar xvfz apache-servicemix-4.4.1-fuse-07-11.tar.gz
  sudo rm -rf /usr/share/apache-servicemix
  sudo ln -s /usr/share/apache-servicemix-4.4.1-fuse-07-11 /usr/share/apache-servicemix
  sudo chown -R smx-fuse.smx-fuse /usr/share/apache-servicemix
  sudo chown -R smx-fuse.smx-fuse /usr/share/apache-servicemix-4.4.1-fuse-07-11

  sudo cp /vagrant/servicemix/etc/* /usr/share/apache-servicemix/etc
  sudo cp /vagrant/servicemix/deploy/* /usr/share/apache-servicemix/deploy
  sudo cp /vagrant/servicemix/bin/* /usr/share/apache-servicemix/bin

  sudo chown -R smx-fuse.smx-fuse /usr/share/apache-servicemix
  sudo cp /vagrant/servicemix/servicemix.init /etc/init.d/servicemix
  sudo chmod +x /etc/init.d/servicemix
  sudo update-rc.d servicemix defaults 99
  sudo /etc/init.d/servicemix start

  # Install the sudoers file
  sudo cp /vagrant/servicemix/jenkins /etc/sudoers.d
  sudo chmod 600 /etc/sudoers.d/jenkins
  sudo chown root  /etc/sudoers.d/jenkins
END
