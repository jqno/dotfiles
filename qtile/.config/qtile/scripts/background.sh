#!/usr/bin/env bash

if [[ "$1" == "known" ]]; then
  feh --bg-fill ~/Dropbox/wallpapers/2017-05-31*Kopenhagen*3*.jpg
else
  feh --randomize --bg-fill ~/Dropbox/wallpapers
fi
