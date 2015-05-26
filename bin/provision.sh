#!/usr/bin/env bash

# oracle java with auto license accept
add-apt-repository ppa:webupd8team/java
echo "oracle-java7-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections

# apt source for sbt
echo "deb http://dl.bintray.com/sbt/debian /" | tee /etc/apt/sources.list.d/sbt.list

# update + upgrade system
apt-get update
apt-get upgrade -y

# system packages
python="python2.7 python3.4 python-dev python3.4-dev python-pip python3-pip libxml2-dev libxslt-dev libyaml-dev libcurl4-openssl-dev"
java="oracle-java7-installer oracle-java8-installer oracle-java8-set-default ant maven eclipse eclipse-egit"
misc="git build-essential ca-certificates bzip2 zip unzip gtk-theme-switch gtk2-engines wget curl"

apt-get install -y $python $java $misc

# install docker; TODO: check version and upgrade existing
installed_docker=false
if hash docker 2>/dev/null; then
  echo "Docker already installed"
else
  wget -qO- https://get.docker.com/ | sh
  usermod -aG docker vagrant
  sed -i '/GRUB_CMDLINE_LINUX=""/c\GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"' /etc/default/grub
  update-grub
  installed_docker=true
fi

# install scala -- TODO: check version and upgrade existing
if hash scala 2>/dev/null; then
  echo "Scala already installed"
else
  scala_version="2.11.6"
  echo "Downloading scala $scala_version..."
  scala_deb="scala-$scala_version.deb"
  wget -q -O /tmp/$scala_deb http://downloads.typesafe.com/scala/$scala_version/$scala_deb
  dpkg -i /tmp/$scala_deb
  rm /tmp/$scala_deb
fi

# sbt -- note: they have no published key, hence the need to force
apt-get install -y --force-yes sbt

# rvm
su - vagrant -c "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"
su - vagrant -c "\curl -sSL https://get.rvm.io | bash -s stable"

# gvm
su - vagrant -c "curl -s get.gvmtool.net | bash"

# misc
gtk-theme-switch2 /usr/share/themes/Clearlooks

# cleanup
apt-get autoremove -y

if [ $installed_docker == true ]; then
  # reboot for grub changes
  echo "Rebooting..."
  reboot
fi