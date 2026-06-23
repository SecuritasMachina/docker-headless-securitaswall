#!/usr/bin/env bash
set -e

echo "Install TigerVNC server"
source $INST_SCRIPTS/commonFunctions.sh

# The old Bintray tarball (dl.bintray.com/tigervnc/stable/...) was permanently shut down in 2021.
# On Ubuntu 24.04 LTS the maintained TigerVNC packages ship in the universe repository.
retry apt-get update
retry apt-get install -y --no-install-recommends \
    tigervnc-standalone-server \
    tigervnc-common \
    tigervnc-tools
