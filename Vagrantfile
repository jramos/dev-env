require 'etc'

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = [Etc.getlogin, "-dev"].join

  config.vm.network "private_network", type: "dhcp"

  [3000, 4000, 5000, 5432, 8080].each do |port|
    config.vm.network "forwarded_port", guest: port, host: port
  end

  config.vm.provider "virtualbox" do |v|
    v.name = [Etc.getlogin, "-dev"].join
    v.memory = 4096
    v.cpus = 8
  end

  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  config.vm.synced_folder "~/src/", "/home/vagrant/src"
  config.vm.provision "file", source: "~/.gitconfig", destination: ".gitconfig"
  config.vm.provision "shell", path: "bin/provision.sh"
end
