#!/usr/bin/env bash

setxkbmap -symbols "pc+us+inet(evdev)+mods(caps_mod3)+mods(compose)" -print | xkbcomp -I$HOME/.config/xkb - $DISPLAY
