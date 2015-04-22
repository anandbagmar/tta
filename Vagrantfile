# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 4
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y ruby rails3 bundler mysql-server-5.5 git libmysqlclient-dev
    if [ ! -d "tta" ]; then
        git clone https://github.com/anandbagmar/tta.git
        sudo chown vagrant:vagrant -R tta
    fi
    cd tta
    git pull
    bundle install
    echo "You'll find TTA in $HOME/tta"
  SHELL
end
