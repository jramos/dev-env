# dev-env

My development environment. Requires [vagrant](http://www.vagrantup.com/downloads.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

## VM Configuration

  * Ubuntu 14.04 LTS (`ubuntu/trusty64`)
  * 8 CPUs; 8 GB RAM; 40 GB SATA
  * Private DHCP network
  * SSH agent and X11 forwarding

## Dev Tools
  * Oracle Java 7/8
  * Scala 2.11 with sbt, Akka and Play
  * Python 2.7/3.4 and Jython 2.7
  * JRuby 1.7/9.0.0.0 (via rvm)
  * gvm for Groovy/Gradle/Grails
  * Eclipse with Egit and Web Tools Platform (WTP)
  * Ant and Maven
  * Docker 1.0
  * build-essentials, git, libxml/xslt/yaml dev headers

## Basic Usage

    # create and provision the VM
    vagrant up

    # connect
    vagrant ssh

    # stop
    vagrant halt

    # reprovision
    vagrant up --provision

    # destroy
    vagrant destroy

See the [vagrant CLI docs](https://docs.vagrantup.com/v2/cli/index.html) for a full list of commands.

By default, the VM will mount the `src` folder in `~/` to the `src` folder in vagrant's home directory. Additionally, when `vagrant up` is called, `pwd` will be mounted under `/vagrant` on the VM (e.g. the `dev-env` directory).

Your `.gitconfig` is also copied to the VM.

### Optional setup

    # choose a GTK theme for Eclipse
    gtk-theme-switch2

To use the installed version of Eclipse, it is assumed that you have [XQuartz](http://xquartz.macosforge.org/landing/) or a similar X11 implementation (e.g. [Cygwin/X](http://en.wikipedia.org/wiki/Cygwin/X)) installed locally.

## License

Code released under the [MIT License](LICENSE).