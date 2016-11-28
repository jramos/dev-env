#!/usr/bin/env bash

# oracle java with auto license accept
add-apt-repository ppa:webupd8team/java
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections

# update + upgrade system
apt-get update
apt-get upgrade -y

# system packages
java="oracle-java8-installer oracle-java8-set-default oracle-java8-unlimited-jce-policy"
python="python-dev python3-dev python-pip python3-pip"
misc="build-essential ca-certificates bzip2 git zip unzip wget curl autoconf automake"

apt-get install -y $java $python $misc

# cleanup
apt-get autoremove -y
