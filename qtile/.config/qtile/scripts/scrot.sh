#!/bin/bash

if [[ "$1" == 'window' ]]; then
  scrot -s ~/Pictures/%Y-%m-%d_%H.%M.%S_window.png
else
  scrot ~/Pictures/%Y-%m-%d_%H.%M.%S_full.png
fi
