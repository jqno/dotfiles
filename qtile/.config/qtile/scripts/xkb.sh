#!/usr/bin/env bash

setkeymap() {
  mods=$1
  device=""
  [ "$2" ] && device="-i $2"
  setxkbmap -print | sed "s/\(xkb_symbols.*\".*\)\(\".*\)/\1$mods\2/" | xkbcomp $device "-I$HOME/.config/xkb" - "$DISPLAY"
}

mods="+mods(caps_mod3)+mods(compose)"
setkeymap $mods
