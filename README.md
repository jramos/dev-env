# dev-env

Vagrant Development Environment. Requires [vagrant](http://www.vagrantup.com/downloads.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

## Basic Usage

    # create and provision the VM
    vagrant up

    # connect to it
    vagrant ssh

See the [vagrant CLI docs](https://docs.vagrantup.com/v2/cli/index.html) for a full list of commands.

By default, the VM will mount the `src` folder in your home directory to the `src` folder in vagrant's home directory. Additionally, the `pwd` when `vagrant up` is called will be mounted under `/vagrant` on the VM (e.g. the `dev-env` directory).

### Optional setup

    # choose a GTK theme for Eclipse over X11
    gtk-theme-switch2

## Virtual Machine Configuration

  * Ubuntu 14.04 LTS (`ubuntu/trusty64`)
  * 8 CPUs; 8 GB RAM; 40 GB SATA
  * Private DHCP network
  * SSH agent and X11 forwarding

## Provisioned Tools
  * Oracle Java 7/8
  * Scala 2.11 with sbt, Akka and Play
  * Python 2.7/3.4 and Jython 2.7
  * JRuby 1.7/9.0.0.0 (via rvm)
  * Groovy enVironment Manager (gvm) for Groovy/Gradle/Grails
  * Eclipse with Egit and Web Tools Platform (WTP)
  * Ant and Maven
  * Docker 1.0
  * build-essentials, git, libxml/xslt/yaml dev headers

## License

Code released under the [MIT License](LICENSE).