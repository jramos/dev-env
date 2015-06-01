require 'etc'

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = [Etc.getlogin, "-dev"].join

  config.vm.network "private_network", type: "dhcp"
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 5432, host: 5432
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  config.vm.provider "virtualbox" do |v|
    v.name = [Etc.getlogin, "-dev"].join
    v.memory = 8192
    v.cpus = 8
  end

  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  config.vm.synced_folder "~/src/", "/home/vagrant/src"
  config.vm.provision "file", source: "~/.gitconfig", destination: ".gitconfig"
  config.vm.provision "shell", path: "bin/provision.sh"
end