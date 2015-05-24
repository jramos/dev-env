#!/usr/bin/env bash

# sources + keys for oracle java 8 with auto license accept
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886

# update + upgrade system
apt-get update
apt-get upgrade -y

# install new packages
dev_pkgs="python-dev python3.4-dev libxml2-dev libxslt-dev libyaml-dev"
languages="oracle-java8-installer oracle-java8-set-default python3.4"
tools="git build-essential python-pip python3-pip ant unzip"

apt-get install -y $dev_pkgs $languages $tools

# cleanup
apt-get autoremove -y