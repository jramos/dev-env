require "etc"

@box_name = "xenial64"
@hostname = [Etc.getlogin, "-", @box_name].join
@vm_cpus = 4
@vm_mem = 4096
@vm_opts = [
  ["--hpet", "on"],
  ["--hwvirtex", "on"],
  ["--largepages", "on"],
  ["--uart1", "off"],
  ["--uartmode1", "disconnected"]
]

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/#{@box_name}"
  config.vm.hostname = @hostname
  config.vm.network :private_network, type: :dhcp

  config.vm.provider :virtualbox do |vb|
    vb.name = @hostname
    vb.memory = @vm_mem
    vb.cpus = @vm_cpus

    @vm_opts.each {|opts| vb.customize ["modifyvm", :id] + opts}
  end

  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  config.vm.synced_folder "", "/vagrant", disabled: true
  config.vm.synced_folder File.join(Dir.home, "src"), "/home/ubuntu/src", type: "nfs", create: true
  config.vm.provision "shell", path: File.join("bin", "provision.sh")

  [".bash_aliases", ".gitconfig", ".gitignore_global"].each do |file|
    home_dir_file = File.join(Dir.home, file)
    if File.exists?(home_dir_file)
      config.vm.provision "file", source: home_dir_file, destination: file
    end
  end
end
