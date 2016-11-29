require "etc"

@box_name = "xenial64"
@hostname = [Etc.getlogin, "-#{@box_name}"].join

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/#{@box_name}"
  config.vm.hostname = @hostname
  config.vm.network "private_network", type: "dhcp"

  [3000, 3306, 5432, 8000, 8080].each do |port|
    config.vm.network "forwarded_port", guest: port, host: port
  end

  config.vm.provider "virtualbox" do |v|
    v.name = @hostname
    v.memory = 4096
    v.cpus = 4
    v.customize ["modifyvm", :id, "--uartmode1", "disconnected"]
  end

  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  config.vm.synced_folder "~/src/", "/home/ubuntu/src", type: "nfs", create: true

  [".gitconfig", ".gitignore_global"].each do |file|
    if File.exists?("#{ENV['HOME']}/#{file}")
      config.vm.provision "file", source: "#{ENV['HOME']}/#{file}", destination: file
    end
  end

  config.vm.provision "shell", path: "bin/provision.sh"
end
