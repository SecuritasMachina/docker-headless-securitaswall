#!/usr/bin/env bash
### every exit != 0 fails the script
set -e
set -u

NO_VNC_VERSION=1.5.0
WEBSOCKIFY_VERSION=0.12.0

echo "Install noVNC $NO_VNC_VERSION - HTML5 based VNC viewer"
mkdir -p "$NO_VNC_HOME/utils/websockify"
wget -qO- "https://github.com/novnc/noVNC/archive/v${NO_VNC_VERSION}.tar.gz" | tar xz --strip 1 -C "$NO_VNC_HOME"
wget -qO- "https://github.com/novnc/websockify/archive/v${WEBSOCKIFY_VERSION}.tar.gz" | tar xz --strip 1 -C "$NO_VNC_HOME/utils/websockify"
chmod +x -v "$NO_VNC_HOME"/utils/*.sh
## create index.html to forward automatically to `vnc_lite.html`
ln -s "$NO_VNC_HOME/vnc_lite.html" "$NO_VNC_HOME/index.html"
