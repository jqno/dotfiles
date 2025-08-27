#!/usr/bin/env bash

if [[ -f ".Makefile" ]]; then
  make -s -f "$HOME/.config/makefile/Makefile" -f ".Makefile" "$@" 2>&1 | grep -v "warning:.*recipe"
else
  make -s -f "$HOME/.config/makefile/Makefile" "$@"
fi
