#!/usr/bin/env sh

rm -rf ~/.vim/autoload
rm -rf ~/.vim/plugged

echo "Installing Vim plugins..."

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim -c JqnoPlugInitialInstall

