require 'etc'

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "virtualbox" do |v|
    v.memory = 8192
    v.cpus = 8
  end

  config.vm.box = "debian/jessie64"
  config.vm.hostname = [Etc.getlogin, "-dev"].join
  config.vm.network "private_network", type: "dhcp"

  config.vm.provision "file", source: "~/.gitconfig", destination: ".gitconfig"
  config.vm.provision "shell", path: "bin/provision.sh"

  config.vm.provision "docker",
    images: ["debian:jessie"]

  config.vm.provision "docker" do |d|
  end
end