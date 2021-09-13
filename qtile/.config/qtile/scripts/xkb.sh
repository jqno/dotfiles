#!/usr/bin/env bash

setkeymap() {
  mods=$1
  device_id=$2
  mapping=$(setxkbmap -print | sed "s/\(xkb_symbols.*\".*\)\(\".*\)/\1$mods\2/")

  if [ "$device_id" ]; then
    echo "Applying mappings for device $device_id"
    echo "$mapping" | xkbcomp -i "$device_id" "-I$HOME/.config/xkb" - "$DISPLAY" > /dev/null 2>&1
  else
    echo "Applying mappings for all devices"
    echo "$mapping" | xkbcomp "-I$HOME/.config/xkb" - "$DISPLAY" > /dev/null 2>&1
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
apple_id=$(kbd_id "Apple")
mods="+mods(caps_mod3)+mods(compose)+apple(swap_alt_super)"
[ "$apple_id" ] && setkeymap "$mods" "$apple_id"
