#!/usr/bin/env bash
### every exit != 0 fails the script
set -e
source $INST_SCRIPTS/commonFunctions.sh
echo "Install common tools for further installation"

apt-get install -y $(awk -F: '/^[^#]/ { print $1 }' $INST_SCRIPTS/package.lst) 

# Register the SecuritasMachina APT repo using the modern keyring layout
# (`apt-key` was removed in Ubuntu 23.04+; use `signed-by=` instead).
install -d -m 0755 /etc/apt/keyrings
retry curl -fsSL https://www.securitasmachina.com/SecuritasMachina.gpg.key \
    | gpg --dearmor -o /etc/apt/keyrings/securitasmachina.gpg
chmod 0644 /etc/apt/keyrings/securitasmachina.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/securitasmachina.gpg] https://updates.securitasmachina.com/repos/apt/ubuntu $(lsb_release -cs) stable" \
    > /etc/apt/sources.list.d/securitasmachina.list

retry apt-get update

retry apt -o Dpkg::Options::="--force-confnew" install -y securitas-wall securitas-wall-tomcat
