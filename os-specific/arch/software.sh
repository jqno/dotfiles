#!/usr/bin/env bash

echo "** Some dependencies need the administrator password:"
sudo -v

echo "** Installing dependencies..."

function install_pacman() {
  sudo pacman --noconfirm -S "$1"
}

function install_aur() {
  yay --noconfirm -S "$1"
}

install_pacman kitty

install_pacman docker
install_pacman docker-compose
install_pacman gvfs-smb
install_pacman libxcrypt-compat
install_pacman tlp
install_pacman tlp-rdw
install_pacman wmctrl
install_pacman zsh

install_pacman noto-fonts-emoji
install_aur ttf-code2000
install_pacman ttf-fira-code
install_pacman ttf-font-awesome
install_pacman ttf-opensans
