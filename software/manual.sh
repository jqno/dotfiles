#!/usr/bin/env sh

BIN="$HOME/bin"
rm -rf $BIN
mkdir $BIN


# Java toolchain
curl -s "https://get.sdkman.io?rcupdate=false" | bash
. $HOME/.sdkman/bin/sdkman-init.sh
sdk install java 8.0.265.hs-adpt 
sdk install java 11.0.8.hs-adpt 


# Rust toolchain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile complete


# Powerlevel10k prompt
mkdir $BIN/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $BIN/powerlevel10k


# Yabai window manager
brew install koekeishiya/formulae/yabai
sudo yabai --install-sa
brew services start yabai
killall Dock

