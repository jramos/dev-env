# dev-env

A modern development environment. Requires [vagrant](http://www.vagrantup.com/downloads.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

## System information

### VM configuration

  * Ubuntu 14.04.2 LTS ([ubuntu/trusty64](https://atlas.hashicorp.com/ubuntu/boxes/trusty64))
  * 8 CPUs; 8 GB RAM; 40 GB SATA
  * Private DHCP network
  * SSH agent and X11 forwarding

### Languages

  * Java - Oracle 7/8, OpenJDK 7
  * Scala 2.11 + sbt
  * Python 2.7/3.4 + pip
  * rvm for Ruby/JRuby
  * gvm for Groovy/Gradle

### Dev Tools

  * Docker 1.6 and Compose
  * Eclipse 4.4
  * Ant and Maven
  * build-essentials, misc utilities and dev libs

## Basic usage

Create and start the VM:

    vagrant up

Connect to it over SSH:

    vagrant ssh

Stop the VM:

    vagrant halt

Reprovision:

    vagrant up --provision

Destroy:

    vagrant destroy

See the [vagrant CLI docs](https://docs.vagrantup.com/v2/cli/index.html) for a full list of commands.

### Shared folders

By default, when `vagrant up` is called, `pwd` is mounted as `/vagrant` in the VM. Additionally, this environment will share your `~/src` folder as `/home/vagrant/src`.

Your local `.gitconfig` is copied to the VM when provisioned, as well.

### Optional Setup

    # choose a new GTK theme for Eclipse
    gtk-theme-switch2

By default, the environment uses Clearlooks. To use the installed version of Eclipse, it is assumed that you have [XQuartz](http://xquartz.macosforge.org/landing/) or a similar X11 implementation (e.g. [Cygwin/X](http://en.wikipedia.org/wiki/Cygwin/X)) installed locally.

## Resources

  * [Vagrant Documentation](https://docs.vagrantup.com/v2/)
  * [Docker User Guide](https://docs.docker.com/userguide/)

## License

Code released under the [MIT License](LICENSE).