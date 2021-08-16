#!/usr/bin/env bash

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"

function installCoursier() {
  echo "** Installing Coursier dependencies..."
  source $PWD/software/macos/install_coursier.sh
  if [ $? -ne 0 ]; then
    echo "** Coursier failed"
    exit 1
  fi
}

function installNpm() {
  echo "** Installing npm dependencies..."
  source $PWD/software/macos/install_npm.sh
  if [ $? -ne 0 ]; then
    echo "** npm failed"
    exit 1
  fi
}

function installGem() {
  echo "** Installing Gem dependencies..."
  source $PWD/software/macos/install_gem.sh
  if [ $? -ne 0 ]; then
    echo "** Gem failed"
    exit 1
  fi
}

function installPip() {
  echo "** Installing Pip dependencies..."
  source $PWD/software/macos/install_pip.sh
  if [ $? -ne 0 ]; then
    echo "** Pip failed"
    exit 1
  fi
}

function installManual() {
  echo "** Installing manual dependencies..."
  source $PWD/software/macos/install_manual.sh
  if [ $? -ne 0 ]; then
    echo "** Manual failed"
    exit 1
  fi
}

installManual
installCoursier
installNpm
installGem
installPip

