#!/usr/bin/env bash

echo "** Some dependencies need the administrator password:"
sudo -v

echo "** Installing dependencies..."

function install_pacman() {
  sudo pacman --noconfirm -S $1
}

function install_aur() {
  sudo yay --noconfirm -S $1
}

function install_pip() {
  pip install --user --upgrade $1
}


install_pacman npm
install_pacman python-pip
install_aur coursier

install_pacman abcde
install_pacman brightnessctl
install_pacman docker
install_pacman docker-compose
install_pacman eyed3
install_pacman fd
install_pacman feh
install_pacman fzf
install_pacman gnupg
install_pacman google-chrome
install_pacman intellij-idea-community-edition
install_pacman jq
install_pacman keepassxc
install_pacman kitty
install_pacman lame
install_pacman maven
install_pacman neovim
install_pacman pandoc
install_pacman ripgrep
install_pacman rofimoji
install_pacman scrot
install_pacman spotify
install_pacman stow
install_pacman the_silver_searcher
install_pacman tig
install_pacman tlp
install_pacman tlp-rdw
install_pacman ttf-fira-code
install_pacman ttf-font-awesome
install_pacman ttf-opensans
install_pacman universal-ctags
install_pacman vim
install_pacman wmctrl
install_pacman xautolock
install_pacman xclip
install_pacman zsh-autosuggestions
install_pacman zsh-syntax-highlighting

install_aur jabba
install_aur jekyll
install_aur rambox
install_aur zsh-theme-powerlevel10k-git

install_pip pynvim

mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
npm install --global chokidar chokidar-cli
npm install --global prettier prettier-plugin-java



BIN="$HOME/bin"
rm -rf $BIN
mkdir $BIN

# Java-debug
echo "** Installing java-debug"
pushd $BIN > /dev/null
git clone https://github.com/microsoft/java-debug.git
cd java-debug
./mvnw clean install -DskipTests
popd > /dev/null


# VSCode-java-test
echo "** Installing vscode-java-test"
pushd $BIN > /dev/null
git clone https://github.com/microsoft/vscode-java-test.git
cd vscode-java-test
npm install
npm run build-plugin
popd > /dev/null

