#!/usr/bin/env bash
### every exit != 0 fails the script
set -e
set -o xtrace
#echo "en_US.UTF-8 UTF-8" > /etc/locate.gen
source $INST_SCRIPTS/commonFunctions.sh
echo "Using Proxy: http_proxy=$http_proxy"   
#retry apt-get install -y --no-install-recommends apt-utils     
retry apt-get update && apt-get install -y --no-install-recommends debconf gnupg2 curl gpg-agent openssl apt-utils net-tools software-properties-common locales
retry apt-get upgrade -y
sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen
#export LANGUAGE=en_US.utf8
#export LANG=en_US.utf8
#export LC_ALL=en_US.utf8
#export LC_ALL=
#locale-gen en_US.utf8

#dpkg-reconfigure locales

locale-gen
#dpkg-reconfigure locales 
#locale-gen en_US.UTF-8
#update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
