#!/usr/bin/env bash

# oracle java with auto license accept
add-apt-repository ppa:webupd8team/java
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections

# apt source for elasticsearch
\curl -sSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-5.x.list

# apt source for rabbitmq
\curl -sSL https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | apt-key add -
echo "deb http://www.rabbitmq.com/debian/ testing main" | tee -a /etc/apt/sources.list.d/rabbitmq.list

# update + upgrade system
apt-get update
apt-get upgrade -y

# system packages
java="oracle-java8-installer oracle-java8-set-default oracle-java8-unlimited-jce-policy"
langs="python-dev python3-dev python-pip python3-pip php php-pear"
services="elasticsearch mysql-server mysql-client postgresql postgresql-client redis-server rabbitmq-server"
libs="libmysqlclient-dev libpq-dev"
misc="autoconf automake avahi-daemon build-essential bzip2 ca-certificates cmake curl git unzip wget zip"

DEBIAN_FRONTEND=noninteractive apt-get install -q -y $java $langs $services $libs $misc

# rvm
su - ubuntu -c "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"
su - ubuntu -c "\curl -sSL https://get.rvm.io | bash -s stable --ruby=2.3"

# node.js + npm
curl -sL https://deb.nodesource.com/setup_7.x | bash -
apt-get install -y nodejs
npm install npm@latest -g

# golang
su - ubuntu -c "\curl -sSL https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash -"
su - ubuntu -c "gvm install go1.7 -B"
su - ubuntu -c "gvm use go1.7"

# SDKMAN!
su - ubuntu -c "\curl -sSL https://get.sdkman.io | bash"

if [ ! -f "/home/ubuntu/.ssh/id_rsa" ]; then
  # generate SSH key and authorize locally
  su - ubuntu -c "ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa"
  su - ubuntu -c "chmod 600 ~/.ssh/id_rsa.pub"
  su - ubuntu -c "cat ~/.ssh/id_rsa.pub | tee -a ~/.ssh/authorized_keys"
fi

# cleanup
service_names=(elasticsearch mysql postgresql rabbitmq-server redis-server)

for service_name in "${service_names[@]}"; do
  service $service_name stop && update-rc.d $service_name disable
done

apt-get autoremove -y
