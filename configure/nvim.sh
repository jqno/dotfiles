#!/usr/bin/env sh

rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim

echo "Installing Neovim plugins..."

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim -c PlugInstall +qall
nvim -c PlugRevert +qall
nvim -c MetalsInstall +qall

