#!/usr/bin/env bash

echo "** Some dependencies need the administrator password:"
sudo -v

echo "** Installing dependencies..."

function install_pacman() {
  sudo pacman --noconfirm -S $1
}

function install_aur() {
  yay --noconfirm -S $1
}

function install_pip() {
  pip install --user --upgrade $1
}

function install_npm() {
  npm install --global $1
}


# Package managers
install_aur coursier
install_aur jabba
install_pacman npm
install_pacman python-pip

mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

# Window manager components
install_pacman brightnessctl
install_pacman feh
install_aur picom-jonaburg-git
install_pacman rofimoji
install_pacman scrot
install_pacman tlp
install_pacman tlp-rdw
install_pacman wmctrl
install_pacman xautolock
install_pacman xclip

# Tools
install_pacman abcde
install_pacman bat
install_npm chokidar
install_npm chokidar-cli
install_pacman docker
install_pacman docker-compose
install_pacman dust
install_pacman duf-bin
install_pacman exa
install_pacman eyed3
install_pacman fd
install_pacman fzf
install_pacman github-cli
install_pacman gnupg
install_aur jekyll
install_pacman jq
install_pacman lame
install_pacman maven
install_pacman neovim
install_pacman pandoc
install_npm prettier
install_npm prettier-plugin-java
install_pacman ripgrep
install_pacman stow
install_pacman the_silver_searcher
install_pacman tig
install_pacman tldr
install_pacman universal-ctags
install_pacman vim
install_aur zsh-theme-powerlevel10k-git

# Applications
install_pacman google-chrome
install_pacman intellij-idea-community-edition
install_pacman keepassxc
install_pacman kitty
install_aur rambox-bin
install_pacman spotify

# Fonts
install_pacman ttf-fira-code
install_pacman ttf-font-awesome
install_pacman ttf-opensans

# Language Servers
install_pacman efm-langserver
install_pacman flake8
install_aur lua-format
install_pacman lua-language-server
install_npm markdownlint
install_npm markdownlint-cli
install_pacman python-lsp-server
install_aur vale-bin

# Dependencies
install_pacman zsh-autosuggestions
install_pacman zsh-syntax-highlighting
install_pip pynvim


# Manual tools
BIN="$HOME/bin"
rm -rf $BIN
mkdir $BIN

ln -s /sbin/coursier $BIN/cs

# JDT.LS
echo "** Installing jdt.ls"
mkdir $BIN/jdtls
pushd $BIN/jdtls > /dev/null
curl -L -o jdtls.tar.gz http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz
tar xf jdtls.tar.gz
rm jdtls.tar.gz
curl -L -o lombok.jar https://projectlombok.org/downloads/lombok.jar
popd > /dev/null

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

# Vale Alex styles
echo "** Installing some styles for Vale linter"
rm -rf ~/.vale
mkdir -p ~/.vale/sources
pushd ~/.vale > /dev/null

git clone https://github.com/errata-ai/alex sources/alex
ln -s sources/alex/alex alex
git clone https://github.com/errata-ai/proselint sources/proselint
ln -s sources/proselint/proselint proselint
rm proselint/Annotations.yml # Let's allow words like NOTE, TODO and FIXME

popd > /dev/null
