#!/usr/bin/env bash
### every exit != 0 fails the script
set -e
source $INST_SCRIPTS/commonFunctions.sh
echo "Install common tools for further installation"

apt-get install -y $(awk -F: '/^[^#]/ { print $1 }' $INST_SCRIPTS/package.lst) 

retry curl -fsSL https://www.securitasmachina.com/SecuritasMachina.gpg.key | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://updates.securitasmachina.com/repos.dev/apt/ubuntu  \
   $(lsb_release -cs) \
   stable"
retry apt-get update
echo 'Installing Squid w/ SSL'
cd /tmp
retry wget -q https://github.com/SecuritasMachina/SecureWall_Secure_Router/blob/master/debs/squid_4.6-1+deb10u1_amd64.deb
retry wget -q https://github.com/SecuritasMachina/SecureWall_Secure_Router/blob/master/debs/squid-cgi_4.6-1+deb10u1_amd64.deb
retry wget -q https://github.com/SecuritasMachina/SecureWall_Secure_Router/blob/master/debs/squid-common_4.6-1+deb10u1_all.deb
retry wget -q https://github.com/SecuritasMachina/SecureWall_Secure_Router/blob/master/debs/squid-purge_4.6-1+deb10u1_amd64.deb
retry wget -q https://github.com/SecuritasMachina/SecureWall_Secure_Router/blob/master/debs/squidclient_4.6-1+deb10u1_amd64.deb

apt -o Dpkg::Options::="--force-confnew" install ./*.deb -y

retry apt -o Dpkg::Options::="--force-confnew" install -y securitas-wall
