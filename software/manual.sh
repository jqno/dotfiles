#!/usr/bin/env sh

BIN="$HOME/bin"
rm -rf $BIN
mkdir $BIN


# Rust toolchain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile complete


# Yabai window manager
brew install koekeishiya/formulae/yabai
sudo yabai --install-sa
brew services start yabai
killall Dock

