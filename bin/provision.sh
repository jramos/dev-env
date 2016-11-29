#!/usr/bin/env bash

# oracle java with auto license accept
add-apt-repository ppa:webupd8team/java
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections

# apt source for sbt
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list

# update + upgrade system
apt-get update
apt-get upgrade -y

# system packages
java="oracle-java8-installer oracle-java8-set-default oracle-java8-unlimited-jce-policy"
python="python-dev python3-dev python-pip python3-pip"
misc="build-essential ca-certificates bzip2 git zip unzip wget curl autoconf automake sbt"

apt-get install -y $java $python $misc

# rvm
su - ubuntu -c "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"
su - ubuntu -c "\curl -sSL https://get.rvm.io | bash -s stable"

# node.js + npm
curl -sL https://deb.nodesource.com/setup_7.x | bash -
apt-get install -y nodejs
npm install npm@latest -g

if [ ! -f "/home/ubuntu/.ssh/id_rsa" ]; then
  # generate SSH key and authorize locally
  su - ubuntu -c "ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa"
  su - ubuntu -c "chmod 600 ~/.ssh/id_rsa.pub"
  su - ubuntu -c "cat ~/.ssh/id_rsa.pub | tee -a ~/.ssh/authorized_keys"
fi

# cleanup
apt-get autoremove -y
