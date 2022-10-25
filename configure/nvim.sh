#!/usr/bin/env sh

rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
mkdir ~/.cache/nvim

PLUG_VIM="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"

sh -c "curl -fLo $PLUG_VIM --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

echo "*** Installing Neovim plugins... this may take a while..."

nvim --headless \
  -u "$HOME"/.config/nvim/plugins.vim \
  -c PlugInstall \
  -S "$HOME"/.config/nvim/plugin.lock.vim \
  -c qall
