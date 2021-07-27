#!/usr/bin/env bash

echo "** Some dependencies need the administrator password:"
sudo -v

echo "** Installing Ubuntu dependencies..."

function install_apt() {
  sudo apt install --yes $1
}

function install_snap() {
  sudo snap install $1
}


install_apt software-properties-common
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update


install_apt npm
install_apt python3
install_apt python3-pip
install_snap ruby

install_apt abcde
install_apt aptitude
install_apt blueman
install_apt brightnessctl
install_apt curl
install_apt docker
install_apt docker-compose
install_apt eyed3
install_apt fd-find
install_apt feh
install_apt fonts-comic-neue
install_apt fonts-firacode
install_apt fonts-open-sans
install_apt fzf
install_apt git
install_apt gnome-tweaks
install_apt gnupg
install_apt i3lock
install_apt jq
install_apt kitty
install_apt lame
install_apt maven
install_apt neovim
install_apt ninja-build
install_apt numlockx
install_apt pandoc
install_apt playerctl
install_apt python3-neovim
install_apt ripgrep
install_apt rofi
install_apt rsync
install_apt scala
install_apt scrot
install_apt silversearcher-ag
install_apt stow
install_apt subversion
install_apt tig
install_apt tlp
install_apt tlp-rdw
install_apt vim
install_apt wmctrl
install_apt xautolock
install_apt xclip
install_apt zsh
install_apt zsh-autosuggestions
install_apt zsh-syntax-highlighting

install_snap chromium
install_snap intellij-idea-community
install_snap keepassxc
install_snap rambox
install_snap spotify
install_snap universal-ctags


## Qtile
PIP=""
if [ -x "$(command -v pip3)" ]; then
  PIP="pip3"
elif [ -x "$(command -v pip)" ]; then
  PIP="pip"
else
  echo "** Could not find a valid Pip executable. Aborting!"
  exit 1
fi

$PIP install xcffib
$PIP install --no-cache-dir cairocffi
$PIP install dbus-next
$PIP install python-xlib
$PIP install qtile

sudo cat > /usr/share/xsessions/qtile.desktop <<EOF
[Desktop Entry]
Name=Qtile
Comment=Qtile session
Exec=/home/jqno/.local/bin/qtile start
Type=Application
Keywords=tiling;wm;windowmanager
EOF
