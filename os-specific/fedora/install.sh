#!/usr/bin/env bash

echo "*** Some dependencies need the administrator password:"
sudo -v

echo "*** Installing dependencies..."


# Terminal
sudo dnf --assumeyes install kitty


# System tools
sudo dnf --assumeyes install @development-tools
sudo dnf --assymeyes install docker
sudo dnf --assymeyes install docker-compose
sudo dnf --assumeyes install gcc-g++
sudo dnf --assumeyes install libxcrypt-compat
sudo dnf --assumeyes install procps-ng
sudo dnf --assumeyes install stow
sudo dnf --assumeyes install tlp
sudo dnf --assumeyes install tlp-rdw
sudo dnf --assumeyes install ulauncher
sudo dnf --assumeyes install util-linux
sudo dnf --assumeyes install wl-clipboard
sudo dnf --assumeyes install xclip
sudo dnf --assumeyes install xsel
sudo dnf --assumeyes install xprop
sudo dnf --assumeyes install zsh


# Fonts
sudo dnf --assumeyes install fontawesome5-fonts-all
sudo dnf --assumeyes install unifont-fonts
