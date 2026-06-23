#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

# MySQL 8.4 LTS generic-linux tarballs are built against glibc 2.28
MYSQL_DIR="$MYSQL_FLAVOR-linux-glibc2.28-x86_64"

if [ -d "$HOME/apps/$MYSQL_DIR" ]
then
        echo "$HOME/apps/$MYSQL_DIR exists, skipping install"
else
	echo "Installing $MYSQL_FLAVOR"
	mkdir -p "$HOME/data/mysql"
	mkdir -p "$HOME/apps"

	rm -rf "$HOME/apps/mysql"
	rm -rf "$HOME/apps/$MYSQL_DIR"
	tar -xvf "$HOME/.dockerDevTools/archives/$MYSQL_DIR.tar.xz" -C "$HOME/apps"
fi
if [ -d "$HOME/apps/mysql" ]
then
	echo "Skip $MYSQL_FLAVOR link creation"
else
	echo "Creating link"
	ln -s "$HOME/apps/$MYSQL_DIR" "$HOME/apps/mysql"

fi
