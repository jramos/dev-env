#!/usr/bin/env bash

# oracle java with auto license accept
add-apt-repository ppa:webupd8team/java
echo "oracle-java7-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections

# other apt sources
echo "deb http://dl.bintray.com/sbt/debian /" | tee /etc/apt/sources.list.d/sbt.list

# update + upgrade system
apt-get update
apt-get upgrade -y

# system packages
python="python2.7 python3.4 python-dev python3.4-dev python-pip python3-pip libxml2-dev libxslt-dev libyaml-dev"
java="oracle-java7-installer oracle-java8-installer oracle-java8-set-default ant maven eclipse eclipse-egit"
misc="git build-essential bzip2 zip unzip gtk-theme-switch gtk2-engines"

apt-get install -y $python $java $misc

# docker
wget -qO- https://get.docker.com/ | sh
usermod -aG docker vagrant

# scala
scala_version="2.11.6"
scala_deb="scala-$scala_version.deb"
wget -q -O /tmp/$scala_deb http://downloads.typesafe.com/scala/$scala_version/$scala_deb
dpkg -i /tmp/$scala_deb
rm /tmp/$scala_deb

# sbt -- note: they have no published key, hence the need to force
apt-get install -y --force-yes sbt

# rvm
su - vagrant -c "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"
su - vagrant -c "\curl -sSL https://get.rvm.io | bash -s stable"

# gvm
su - vagrant -c "curl -s get.gvmtool.net | bash"

# cleanup
apt-get autoremove -y
