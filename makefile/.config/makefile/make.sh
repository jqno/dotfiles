#!/usr/bin/env bash

if [[ -f ".Makefile" ]]; then
  make -s -f "$HOME/.config/makefile/Makefile" -f ".Makefile" "$@" 2> >(grep -v "warning:.*recipe" >&2)
else
  make -s -f "$HOME/.config/makefile/Makefile" "$@"
fi
