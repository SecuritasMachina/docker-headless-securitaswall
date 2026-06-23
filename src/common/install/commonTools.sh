#!/usr/bin/env bash
### every exit != 0 fails the script
set -e
source $INST_SCRIPTS/commonFunctions.sh
echo "Install common tools for further installation"

apt-get install -y $(awk -F: '/^[^#]/ { print $1 }' $INST_SCRIPTS/package.lst) 

# Register the SecuritasMachina APT repo using the modern keyring layout.
# `apt-key` was removed in Ubuntu 23.04+, so the signing key must be dropped into
# /etc/apt/keyrings and referenced via `signed-by=` instead of `apt-key add`.
install -d -m 0755 /etc/apt/keyrings
retry curl -fsSL https://www.securitasmachina.com/SecuritasMachina.gpg.key \
    | gpg --dearmor -o /etc/apt/keyrings/securitasmachina.gpg
chmod 0644 /etc/apt/keyrings/securitasmachina.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/securitasmachina.gpg] https://updates.securitasmachina.com/repos/apt/ubuntu $(lsb_release -cs) stable" \
    > /etc/apt/sources.list.d/securitasmachina.list
retry apt-get update

echo 'Installing Squid w/ SSL'
cd /tmp
# GitHub /blob/ URLs return an HTML page, not the file. Use the raw host so wget
# actually downloads the .deb payloads.
SQUID_DEB_BASE="https://raw.githubusercontent.com/SecuritasMachina/SecureWall_Secure_Router/master/debs"
for deb in \
    squid_4.6-1+deb10u1_amd64.deb \
    squid-cgi_4.6-1+deb10u1_amd64.deb \
    squid-common_4.6-1+deb10u1_all.deb \
    squid-purge_4.6-1+deb10u1_amd64.deb \
    squidclient_4.6-1+deb10u1_amd64.deb ; do
    retry wget -q "$SQUID_DEB_BASE/$deb"
done

apt -o Dpkg::Options::="--force-confnew" install ./*.deb -y

retry apt -o Dpkg::Options::="--force-confnew" install -y securitas-wall
