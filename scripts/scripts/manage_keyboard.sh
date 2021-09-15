#!/usr/bin/env bash

ACTION="$1"
DEVICE="$2"
DESCRIPTION="$3"

genericmods="+mods(caps_mod3)+mods(compose)"
applemods="+apple(swap_alt_super)+apple(tilde)+apple(compose)+mods(caps_mod3)"


setkeymap() {
  mods=$1
  device_id=$2
  regex="s/\(xkb_symbols.*\".*\)\(\".*\)/\1$mods\2/"
  if [ "$device_id" ]; then
    setxkbmap -print | sed "$regex" | xkbcomp -i "$device_id" "-I$HOME/.config/xkb" - "$DISPLAY" > /dev/null 2>&1
  else
    setxkbmap -print | sed "$regex" | xkbcomp "-I$HOME/.config/xkb" - "$DISPLAY" > /dev/null 2>&1
  fi
}

kbd_id() {
  keyboard="$1"
  xinput list | sed -n "s/.*$keyboard.*id=\([0-9]*\).*keyboard.*/\1/p"
}


case $ACTION in
  plug)
    if [[ "$DESCRIPTION" =~ "Apple Inc" || "$DESCRIPTION" =~ "Jan Ouwens’s Keyboard" ]]; then
      echo "Applying mappings for Apple keyboard #$DEVICE"
      setkeymap $applemods $DEVICE
    else
      echo "Applying mappings for generic keyboard #$DEVICE"
      setkeymap $genericmods $DEVICE
    fi
    ;;
  initialize)
    setkeymap $genericmods
    
    apple_id=$(kbd_id "Apple Inc")
    [ "$apple_id" ] || apple_id=$(kbd_id "Jan Ouwens’s Keyboard")
    [ "$apple_id" ] && setkeymap $applemods "$apple_id"
    ;;
  *)
    echo "Run with either initialize or plug"
esac
