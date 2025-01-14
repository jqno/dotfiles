#!/usr/bin/env bash

echo "*** Some dependencies need the administrator password:"
sudo -v

echo "*** Installing dependencies..."

# System tools
sudo apt-get install -y build-essential
sudo apt-get install -y openjdk-21-jdk
sudo apt-get install -y openjdk-21-source
sudo apt-get install -y python3-venv
sudo apt-get install -y stow
sudo apt-get install -y zsh
