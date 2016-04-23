#!/usr/bin/env bash

# oracle java with auto license accept
add-apt-repository ppa:webupd8team/java
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections

# apt source for sbt
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 99E82A75642AC823
echo "deb http://dl.bintray.com/sbt/debian /" | tee /etc/apt/sources.list.d/sbt.list

# update + upgrade system
apt-get update
apt-get upgrade -y

# system packages
python="python2.7 python3.4 python-dev python3.4-dev python-pip python3-pip"
java="oracle-java8-installer oracle-java8-set-default ant maven"
libs="libxml2-dev libxslt-dev libyaml-dev libcurl4-openssl-dev libjemalloc1 libjemalloc-dev libreadline6-dev libgdbm-dev libncurses5-dev libffi-dev libpq-dev libsqlite3-dev sqlite3 qt5-default libqt5webkit5-dev"
misc="git git-flow build-essential ca-certificates bzip2 zip unzip wget curl autoconf automake libtool bison sbt"

apt-get install -y $python $java $libs $misc

# aws
pip install awscli
pip install awsebcli

# misc
grep "vm.overcommit_memory = 1" /etc/sysctl.conf || echo "vm.overcommit_memory = 1" | tee -a /etc/sysctl.conf
grep "net.core.somaxconn = 65535" /etc/sysctl.conf || echo "net.core.somaxconn = 65535" | tee -a /etc/sysctl.conf
grep 'echo "never" > /sys/kernel/mm/transparent_hugepage/enabled' /etc/rc.local || echo 'echo "never" > /sys/kernel/mm/transparent_hugepage/enabled' | tee /etc/rc.local
chmod +x /etc/rc.local

# cleanup
apt-get autoremove -y

# reboot for sysctl and grub changes
echo "Rebooting..."
reboot