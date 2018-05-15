#!/usr/bin/env bash

function installDotfiles() {
  installFor "hammerspoon"
}

PWD=$(pwd)

function installFor() {
  FROM=$1
  if [ "$2" == "" ]; then
    TO=$FROM
  else
    TO=$2
  fi

  echo "Linking $FROM..."
  rm ~/.$TO
  ln -s $PWD/$FROM ~/.$TO
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  installDotfiles
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    installDotfiles
  fi
fi
