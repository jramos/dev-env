# dev-env

A  modern development environment. Requires [vagrant](http://www.vagrantup.com/downloads.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

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
  * Node.js v0.12 + npm
  * rvm for Ruby/JRuby
  * gvm for Groovy/Gradle

### Dev Tools

  * Docker 1.6 and Docker Compose
  * Chef, Chef Zero and Puppet
  * Eclipse 4.4
  * Ant and Maven
  * Chromium Browser
  * build-essentials, misc utilities and dev libs

## Basic usage

### Vagrant

Create and start the VM:

    vagrant up

Connect via SSH:

    vagrant ssh

Stop the VM:

    vagrant halt

Reprovision:

    vagrant up --provision

Destroy:

    vagrant destroy

See the [vagrant CLI docs](https://docs.vagrantup.com/v2/cli/index.html) for a full list of commands.

### Docker Compose

Build the app containers:

    docker-compose build

Start the app containers:

    docker-compose up -d

List all containers:

    docker-compose ps

Run a command on the web container:

    docker-compose run web <some command>

Stop all containers:

    docker-compose stop

Kill all containers:

    docker-compose kill

Destroy all containers:

    docker-compose rm

See the [Docker Compose User Guide](https://docs.docker.com/compose/) for a full list of commands.

## Docker Examples

### Rails

An example script has been provided to initialize a new Rails application. It creates containers for the application, PostgreSQL and Redis, and links them together.

To generate a new Rails app:

    cd examples/rails
    ./init.sh <app_name>

The application is now in `~/src/rails/<app_name>`:

    cd ~/src/rails/<app_name>

Build and start the containers:

    docker-compose build
    docker-compose up -d

Create and migrate the database:

    docker-compose run web rake db:create db:migrate

You should now see the default Rails application page at [http://localhost:3000](http://localhost:3000).

## Shared folders

When `vagrant up` is called, `pwd` is mounted as `/vagrant` in the VM. Additionally, `~/src` will be mounted as `/home/vagrant/src` in the VM.

`~/.gitconfig` is copied from the host to the VM when provisioned, as well.

## Optional Setup

    # choose a new GTK theme for Eclipse
    gtk-theme-switch2

By default, the environment uses Clearlooks. To use the installed version of Eclipse, it is assumed that you have [XQuartz](http://xquartz.macosforge.org/landing/) or a similar X11 implementation (e.g. [Cygwin/X](http://en.wikipedia.org/wiki/Cygwin/X)) installed locally.

## Resources

  * [Vagrant Documentation](https://docs.vagrantup.com/v2/)
  * [Docker User Guide](https://docs.docker.com/userguide/)
  * [Docker Compose](https://docs.docker.com/compose/)
  * [Docker Official Images](https://github.com/docker-library/official-images)

## License

Code released under the [MIT License](LICENSE).