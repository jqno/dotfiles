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

function install_pip() {
  pip install --user --upgrade "$1"
}

install_pacman kitty

install_pacman gvfs-smb
install_pacman libxcrypt-compat
install_pacman tlp
install_pacman tlp-rdw
install_pacman ulauncher
install_pacman wmctrl

install_pacman noto-fonts-emoji
install_aur ttf-code2000
install_pacman ttf-fira-code
install_pacman ttf-font-awesome
install_pacman ttf-opensans

## For ulauncher plugins
install_pip dateparser
install_pip jinja2
install_pip markdown
install_pip parsedatetime
install_pip pint
install_pip python-frontmatter
install_pip pytz
install_pip requests
install_pip simpleeval