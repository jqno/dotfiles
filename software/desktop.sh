#!/usr/bin/env bash

add-apt-repository universe -y
add-apt-repository ppa:agornostal/ulauncher -y
add-apt-repository ppa:keyd-team/ppa -y
apt update

# System tools
apt-get install -y cifs-utils
apt-get install -y dropbox-nautilus
apt-get install -y keyd
apt-get install -y libfuse2
apt-get install -y tlp
apt-get install -y tlp-rdw
apt-get install -y util-linux
apt-get install -y wl-clipboard
apt-get install -y xclip
brew install hexyl
brew install imagemagick
brew install restic
brew install rsync
brew install yazi

# CD ripper
apt-get install -y abcde
apt-get install -y eyed3
apt-get install -y id3v2

# Ulauncher
/usr/bin/pip3 install requests
apt-get install -y ulauncher

# Applications
apt-get install -y kitty
apt-get install -y projecteur
brew install ollama
