#!/usr/bin/env sh

rm -rf ~/.vim/autoload
rm -rf ~/.vim/plugged
rm -rf ~/.config/coc

echo "Installing Vim plugins..."

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim -c JqnoPlugInitialInstall

ln -s $HOME/.vim/plugged/vim-kitty-navigator/pass_keys.py ~/.config/kitty
ln -s $HOME/.vim/plugged/vim-kitty-navigator/neighboring_window.py ~/.config/kitty
