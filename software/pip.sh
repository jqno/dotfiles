#!/usr/bin/env sh

PIP=""
if [ -x "$(command -v pip3)" ]; then
  PIP="pip3"
elif [ -x "$(command -v pip)" ]; then
  PIP="pip"
else
  echo "** Could not find a valid Pip executable. Aborting!"
  exit 1
fi

$PIP install vim-vint

