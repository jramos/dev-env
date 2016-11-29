# dev-env

A development environment. Requires [vagrant](http://www.vagrantup.com/downloads.html), [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and NFS.

## System Information

### VM Configuration

  * Ubuntu 16.04.1 LTS ([ubuntu/xenial64](https://atlas.hashicorp.com/ubuntu/boxes/xenial64))
  * 4 CPUs; 4 GB RAM; 40 GB SATA
  * Private DHCP network
  * SSH agent and X11 forwarding
  * Forwarded ports: `3000`, `3306`, `5432`, `8000`, `8080`

### Languages

  * Oracle JDK 8 (with Unlimited JCE Policy)
  * Python + dev headers/tools (2.7/3.5 + `pip`)
  * Node.js v7 + `npm`
  * Ruby 2.3 (via `rvm`)
  * Go 1.7 (via `gvm`)
  * PHP 7 + `pear`
  * `sbt` for Scala

### Development Tools

  * `autoconf`
  * `automake`
  * `build-essentials`
  * `bzip2`
  * `ca-certificates`
  * `cmake`
  * `curl`
  * `git`
  * `unzip`
  * `wget`
  * `zip`

### Development Libraries

  * `libmysqlclient-dev` for MySQL
  * `libpq-dev` for PostgreSQL

## Basic Usage

Clone this repository:

    git clone git@github.com:jramos/dev-env.git
    cd dev-env

Create and start the VM:

    vagrant up --provision

Connect to it via SSH:

    vagrant ssh

Stop the VM:

    vagrant halt

See the [Vagrant CLI documentation](https://docs.vagrantup.com/v2/cli/index.html) for a full list of commands.

## Shared Folders

When `vagrant up` is called, `pwd` is mounted as `/vagrant` in the VM. This will be the `dev-env` checkout directory if you followed the instructions above. Additionally, `~/src` will be created if necessary and mounted as `/home/vagrant/src` in the VM. Development should be done within the `~/src` folder if you want your code to be accessible from the host (e.g. to edit it using a native GUI).

If present, `~/.gitconfig` and `~/.gitignore_global` are copied from the host to the VM when provisioned, as well.

## Resources

  * [Vagrant Documentation](https://docs.vagrantup.com/v2/)

## License

Code released under the [MIT License](LICENSE).
