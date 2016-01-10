#!/usr/bin/env bash

# oracle java with auto license accept
add-apt-repository ppa:webupd8team/java
echo "oracle-java7-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections

# apt source for sbt
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 99E82A75642AC823
echo "deb http://dl.bintray.com/sbt/debian /" | tee /etc/apt/sources.list.d/sbt.list

# update + upgrade system
apt-get update
apt-get upgrade -y

# system packages
python="python2.7 python3.4 python-dev python3.4-dev python-pip python3-pip"
java="oracle-java7-installer oracle-java8-installer oracle-java8-set-default ant maven"
libs="libxml2-dev libxslt-dev libyaml-dev libcurl4-openssl-dev libjemalloc1 libjemalloc-dev libreadline6-dev libgdbm-dev libncurses5-dev libffi-dev libpq-dev libsqlite3-dev sqlite3 qt5-default libqt5webkit5-dev"
misc="git git-flow build-essential ca-certificates bzip2 zip unzip gtk-theme-switch gtk2-engines wget curl autoconf automake libtool bison"

apt-get install -y $python $java $libs $misc

# install Eclipse Luna; TODO: check version and upgrade existing
if hash eclipse 2>/dev/null; then
  echo "Eclipse already installed"
else
  wget -O /tmp/eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz http://mirrors.xmission.com/eclipse/technology/epp/downloads/release/luna/SR2/eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz
  tar -C /tmp -zxvf /tmp/eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz
  mv /tmp/eclipse /usr/local
  echo "export PATH=\$PATH:/usr/local/eclipse" | tee /etc/profile.d/eclipse.sh
fi

# install docker; TODO: check version and upgrade existing
if hash docker 2>/dev/null; then
  echo "Docker already installed"
else
  wget -O- https://get.docker.com/ | sh
  usermod -aG docker vagrant
  sed -i '/GRUB_CMDLINE_LINUX=""/c\GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"' /etc/default/grub
  update-grub
fi

# docker compose; TODO: check version and upgrade existing
if hash docker-compose 2>/dev/null; then
  echo "Docker Compose already installed"
else
  curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
fi

# install scala; TODO: check version and upgrade existing
if hash scala 2>/dev/null; then
  echo "Scala already installed"
else
  scala_version="2.11.6"
  echo "Downloading scala $scala_version..."
  scala_deb="scala-$scala_version.deb"
  wget -O /tmp/$scala_deb http://downloads.typesafe.com/scala/$scala_version/$scala_deb
  dpkg -i /tmp/$scala_deb
  rm /tmp/$scala_deb
  echo "export SCALA_HOME=/usr/share/scala" | tee /etc/profile.d/scala.sh
fi

# sbt -- note: they have no published key, hence the need to force
apt-get install -y --force-yes sbt

# rvm
su - vagrant -c "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"
su - vagrant -c "\curl -sSL https://get.rvm.io | bash -s stable"

# gvm
su - vagrant -c "curl -s get.gvmtool.net | bash"

# nodejs
curl -sL https://deb.nodesource.com/setup_0.12 | bash -
apt-get install -y nodejs

# aws
pip install awscli
pip install awsebcli

# thrift
# build deps
apt-get install -y libboost-dev libboost-test-dev libboost-program-options-dev libboost-system-dev libboost-filesystem-dev libevent-dev automake libtool flex bison pkg-config g++ libssl-dev ant
# ruby
apt-get install -y ruby-full ruby-dev ruby-rspec rake
# python
apt-get install -y python-all python-all-dev python-all-dbg
# php
apt-get install -y php5-dev php5-cli phpunit
# c/c#
apt-get install -y libglib2.0-dev mono-gmcs mono-devel libmono-system-web2.0-cil nunit nunit-console

wget -O /tmp/thrift-0.9.3.tar.gz http://ftp.wayne.edu/apache/thrift/0.9.3/thrift-0.9.3.tar.gz
cd /tmp                       && \
tar -zxvf thrift-0.9.3.tar.gz && \
cd thrift-0.9.3/              && \
./configure                   && \
make -j8                      && \
make -j8 install              && \
cd /tmp                       && \
rm -rf /tmp/thrift-0.9.3*

# misc
su - vagrant -c "gtk-theme-switch2 /usr/share/themes/Clearlooks"
chmod +x /etc/profile.d/*.sh
grep "vm.overcommit_memory = 1" /etc/sysctl.conf || echo "vm.overcommit_memory = 1" | tee -a /etc/sysctl.conf
grep "net.core.somaxconn = 65535" /etc/sysctl.conf || echo "net.core.somaxconn = 65535" | tee -a /etc/sysctl.conf
grep 'echo "never" > /sys/kernel/mm/transparent_hugepage/enabled' /etc/rc.local || echo 'echo "never" > /sys/kernel/mm/transparent_hugepage/enabled' | tee /etc/rc.local
chmod +x /etc/rc.local

# cleanup
apt-get autoremove -y

# reboot for sysctl and grub changes
echo "Rebooting..."
reboot