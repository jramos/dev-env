#!/usr/bin/env bash

# oracle java with auto license accept
add-apt-repository ppa:webupd8team/java
echo "oracle-java7-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections

# other apt sources
echo "deb http://dl.bintray.com/sbt/debian /" | tee /etc/apt/sources.list.d/sbt.list
echo "deb http://get.docker.io/ubuntu docker main" | tee /etc/apt/sources.list.d/docker.list

# update + upgrade system
apt-get update
apt-get upgrade -y

# system packages
python="python2.7 python3.4 python-dev python3.4-dev python-pip python3-pip libxml2-dev libxslt-dev libyaml-dev"
java="oracle-java7-installer oracle-java8-installer oracle-java8-set-default ant maven eclipse eclipse-egit eclipse-wtp"
misc="git build-essential docker.io unzip gtk-theme-switch gtk2-engines"

apt-get install -y $python $java $misc

# scala
scala_base_version="2.11"
scala_version="$scala_base_version.6"
scala_deb="scala-$scala_version.deb"
wget -q -O /tmp/$scala_deb http://downloads.typesafe.com/scala/$scala_version/$scala_deb
dpkg -i /tmp/$scala_deb
rm /tmp/$scala_deb

# sbt
apt-get install -y sbt

# akka
akka_base_version="2.3.11"
akka_version="$scala_base_version-$akka_base_version"
akka_zip="akka_$akka_version.zip"
akka_home="/usr/local/akka"
echo "export AKKA_HOME=$akka_home" | tee /etc/profile.d/akka.sh
wget -q -O /tmp/$akka_zip http://downloads.typesafe.com/akka/$akka_zip
unzip /tmp/$akka_zip -d /usr/local/
ln -s /usr/local/akka-$akka_base_version $akka_home
rm /tmp/$akka_zip

# play/activator
activator_version="1.3.2"
activator_zip="typesafe-activator-$activator_version-minimal.zip"
wget -q -O /tmp/$activator_zip http://downloads.typesafe.com/typesafe-activator/$activator_version/$activator_zip
unzip /tmp/$activator_zip -d /tmp/
su - vagrant -c "cp /tmp/activator-$activator_version-minimal/activator ~/bin"
su - vagrant -c "cp /tmp/activator-$activator_version-minimal/activator-launch-$activator_version.jar ~/bin"
rm /tmp/$activator_zip
rm -rf /tmp/activator-$activator_version-minimal/

# jython
jython_version="2.7.0"
jython_jar="jython-installer-$jython_version.jar"
wget -q -O /tmp/$jython_jar http://search.maven.org/remotecontent?filepath=org/python/jython-installer/$jython_version/$jython_jar
java -jar /tmp/$jython_jar -s --exclude=demo -d /usr/local/jython-$jython_version
ln -s /usr/local/jython-$jython_version /usr/local/jython
rm /tmp/$jython_jar

# rvm + jruby
su - vagrant -c "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"
su - vagrant -c "\curl -sSL https://get.rvm.io | bash -s stable"
su - vagrant -c "rvm install jruby-1.7"
su - vagrant -c "rvm install jruby-9.0.0.0"

# gvm
su - vagrant -c "curl -s get.gvmtool.net | bash"

# cleanup
apt-get autoremove -y
