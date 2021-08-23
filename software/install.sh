#!/usr/bin/env bash

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"
PLATFORM=$1

read -p "** Do you want to install third-party software? Press ! if you do. " -n 1;
echo ""

if [[ $REPLY =~ ^[!]$ ]]; then
  $PWD/software/install_$PLATFORM.sh

else
  echo "** Skipping installation of third-party software..."
fi

