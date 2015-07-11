# dev-env

A development environment. Requires [vagrant](http://www.vagrantup.com/downloads.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

## System information

### VM configuration

  * Ubuntu 14.04.2 LTS ([ubuntu/trusty64](https://atlas.hashicorp.com/ubuntu/boxes/trusty64))
  * 8 CPUs; 4 GB RAM; 40 GB SATA
  * Private DHCP network
  * SSH agent and X11 forwarding

### Languages

  * Java (Oracle 7/8, OpenJDK 7)
  * Scala (2.11 + sbt)
  * Python (2.7/3.4 + pip/pip3)
  * Node.js (0.12 + npm)
  * rvm (for Ruby/JRuby)
  * gvm (for Groovy/Gradle)

### Dev Tools

  * Docker 1.7 and Docker Compose
  * Chef, Chef Zero and Puppet
  * Eclipse 4.4
  * Ant and Maven
  * Chromium Browser
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

## Optional Setup

    # choose a new GTK theme for X11
    gtk-theme-switch2

By default, the environment uses Clearlooks. To use the installed version of Eclipse or Chromium, it is assumed that you have [XQuartz](http://xquartz.macosforge.org/landing/) or a similar X11 implementation (e.g. [Cygwin/X](http://en.wikipedia.org/wiki/Cygwin/X)) installed locally. This only applies if you want to use X11 applications from the VM on your host.

## Resources

  * [Vagrant Documentation](https://docs.vagrantup.com/v2/)

## License

Code released under the [MIT License](LICENSE).
