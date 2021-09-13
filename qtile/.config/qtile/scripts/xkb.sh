#!/usr/bin/env bash

setkeymap() {
  mods=$1
  device_id=$2
  regex="s/\(xkb_symbols.*\".*\)\(\".*\)/\1$mods\2/"

  if [ "$device_id" ]; then
    echo "Applying mappings for device $device_id"
    setxkbmap -print | sed "$regex" | xkbcomp -i "$device_id" "-I$HOME/.config/xkb" - "$DISPLAY" > /dev/null 2>&1
  else
    echo "Applying mappings for all devices"
    setxkbmap -print | sed "$regex" | xkbcomp "-I$HOME/.config/xkb" - "$DISPLAY" > /dev/null 2>&1
  fi
}

kbd_id() {
  keyboard="$1"
  xinput list | sed -n "s/.*$keyboard.*id=\([0-9]*\).*keyboard.*/\1/p"
}

# Set modifications for all keyboards
mods="+mods(caps_mod3)+mods(compose)"
setkeymap $mods

# Set modifications for Apple keyboards
mods="+apple(swap_alt_super)+apple(compose)+mods(caps_mod3)"
apple_id=$(kbd_id "Apple Inc.")
[ "$apple_id" ] || apple_id=$(kbd_id "Jan Ouwens’s Keyboard")
[ "$apple_id" ] && setkeymap "$mods" "$apple_id"
