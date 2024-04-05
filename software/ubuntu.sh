#!/usr/bin/env bash

echo "*** Some dependencies need the administrator password:"
sudo -v

echo "*** Installing dependencies..."

sudo add-apt-repository universe -y
sudo add-apt-repository ppa:agornostal/ulauncher -y
sudo apt update

# System tools
sudo apt-get install -y build-essential
sudo apt-get install -y dropbox-nautilus
sudo apt-get install -y openjdk-21-jdk
sudo apt-get install -y stow
sudo apt-get install -y tlp
sudo apt-get install -y tlp-rdw
sudo apt-get install -y util-linux
sudo apt-get install -y wl-clipboard
sudo apt-get install -y xclip

# CD ripper
sudo apt-get install -y abcde
sudo apt-get install -y eyed3
sudo apt-get install -y id3v2

# Applications
sudo apt-get install -y kitty
sudo apt-get install -y ulauncher
sudo apt-get install -y zsh
