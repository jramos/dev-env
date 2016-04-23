# dev-env

A development environment. Requires [vagrant](http://www.vagrantup.com/downloads.html), [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and NFS.

## System information

### VM configuration

  * Ubuntu 14.04.3 LTS ([ubuntu/trusty64](https://atlas.hashicorp.com/ubuntu/boxes/trusty64))
  * 8 CPUs; 4 GB RAM; 40 GB SATA
  * Private DHCP network
  * SSH agent and X11 forwarding

### Languages

  * Oracle Java 8
  * Python (2.7/3.4 + pip/pip3)

### Dev Tools

  * sbt
  * Ant and Maven
  * AWS CLI tools
  * build-essentials, misc utilities and dev libs

## Basic Usage

Clone this repository:

    git clone git@github.com:jramos/dev-env.git
    cd dev-env

Create and start the VM:

    vagrant up

Connect to it via SSH:

    vagrant ssh

Stop the VM:

    vagrant halt

See the [Vagrant CLI documentation](https://docs.vagrantup.com/v2/cli/index.html) for a full list of commands.

## Shared Folders

When `vagrant up` is called, `pwd` is mounted as `/vagrant` in the VM. This will be the `dev-env` checkout directory if you followed the instructions above. Additionally, `~/src` will be created if necessary and mounted as `/home/vagrant/src` in the VM. Development should be done within the `~/src` folder if you want your code to be accessible from the host (e.g. to edit it using a native GUI).

If present, `~/.gitconfig` is copied from the host to the VM when provisioned, as well.

## Resources

  * [Vagrant Documentation](https://docs.vagrantup.com/v2/)

## License

Code released under the [MIT License](LICENSE).
