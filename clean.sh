#!/usr/bin/env bash

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"

for dir in $PWD/*; do
  app="$(basename $dir)"
  if [ -d $dir ]; then
    echo "Removing $app"
    stow -D $app 2> /dev/null
  fi
done
