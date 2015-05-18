#!/usr/bin/env bash

# sources + keys for oracle java 8 with auto license accept
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886

# update + upgrade
apt-get update
apt-get upgrade -y

# system packages
languages="oracle-java8-installer oracle-java8-set-default scala python3.4 golang clojure1.6 nodejs"
tools="docker git build-essential"
apt-get install -y $languages $tools

# rvm + ruby
apt-get remove -y ruby
apt-get autoremove -y
su - vagrant -c "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"
su - vagrant -c "\curl -sSL https://get.rvm.io | bash -s stable"

. /home/vagrant/.rvm/scripts/rvm

rvm install ruby
rvm install jruby
rvm install jruby-9.0.0.0
