#!/usr/bin/env bash

mods="+mods(caps_mod3)+mods(compose)"

setxkbmap -print | sed "s/\(xkb_symbols.*\".*\)\(\".*\)/\1$mods\2/" | xkbcomp -I$HOME/.config/xkb - $DISPLAY
