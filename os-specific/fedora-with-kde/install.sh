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
sudo dnf --assumeyes install tlp
sudo dnf --assumeyes install tlp-rdw
sudo dnf --assumeyes install wl-clipboard
sudo dnf --assumeyes install xclip
sudo dnf --assumeyes install xsel
sudo dnf --assumeyes install zsh


# Fonts
sudo dnf --assumeyes install fontawesome5-fonts-all
sudo dnf --assumeyes install unifont-fonts


# KDE
sudo dnf --assumeyes copr enable capucho/bismuth 
sudo dnf --assumeyes install bismuth
sudo dnf --assumeyes install kvantum


# krunner-symbols
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd "$SCRIPT_DIR" > /dev/null

curl https://raw.githubusercontent.com/domschrei/krunner-symbols/master/install.sh | bash
stow --target "$HOME" krunner-symbols

popd > /dev/null
