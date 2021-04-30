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

$PIP install --upgrade pyflakes
$PIP install --upgrade pycodestyle

$PIP install poetry
$PIP install pylint
$PIP install "python-language-server[all]"
$PIP install vim-vint

