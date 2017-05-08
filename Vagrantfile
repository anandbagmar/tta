# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "forwarded_port", guest: 3000, host: 8080

  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus   = 4
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -qy ruby bundler
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -qy mysql-server libmysqlclient-dev
    sudo apt-get install -qy git
    sudo apt-get install -qy libxslt-dev libxml2-dev
    if [ ! -d "tta" ]; then
        git clone https://github.com/anandbagmar/tta.git
        sudo chown vagrant:vagrant -R tta
    fi
    cd tta
    git pull
    bundle install
    echo
    echo "You can now do a 'vagrant ssh'."
    echo "Then:"
    echo "$ cd tta"
    echo "$ rake db:create db:setup db:migrate"
    echo "$ rails s"
    echo "Then point your host system's browser to http://localhost:8080/"
  SHELL
end
