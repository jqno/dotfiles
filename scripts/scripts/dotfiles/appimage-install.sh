#!/bin/bash

## AppImage installer
## Adapted from https://github.com/un1t/appimage-desktop-entry


#
# Initialization
#
APPIMAGE_PATH=$1

if [ "$APPIMAGE_PATH" = "" ]; then
  echo "Usage:"
  echo
  echo "  $0 Foo.AppImage"
  echo "        creates a launcher for Foo"
  echo
  echo "  $0 Foo.AppImage --remove"
  echo "        removes an existing launcher for Foo"
  exit 1
fi

if [ ! -f "$APPIMAGE_PATH" ]; then
  echo "File not found: $APPIMAGE_PATH"
  exit 1
fi

APPIMAGE_FULLPATH=$(readlink -e "$APPIMAGE_PATH")
APPIMAGE_FILENAME=$(basename "$APPIMAGE_PATH")
APP_NAME="${APPIMAGE_FILENAME%%[.-]*}"  # Remove everything following a . or a -
DESKTOP_ENTRY_PATH="${HOME}/.local/share/applications/$APP_NAME.desktop"


if [ "$2" == "--remove" ]; then
  #
  # Remove desktop file
  #
  rm "$DESKTOP_ENTRY_PATH"
  echo "Removed"
  exit 0
fi


#
# Extract AppImage
#
rm -rf /tmp/squashfs-root/
cd /tmp/ || exit 1
"$APPIMAGE_FULLPATH" --appimage-extract
cd /tmp/squashfs-root/ || exit 1


#
# Choose icon
#
echo
echo
echo "Choose icon: "
FILENAMES=("$(ls -d ./*.png)")
i=1
for filename in "${FILENAMES[@]}"
do
    printf " %d) %s\n" "$i"  "$filename"
    i=$(("$i" + 1))
done

read -r SELECTED_INDEX

ICON_SRC=${FILENAMES[$SELECTED_INDEX - 1]}
ICON_EXT="${ICON_SRC##*.}"
ICON_DST="${HOME}/.local/share/icons/$APP_NAME.$ICON_EXT"
cp "$ICON_SRC" "$ICON_DST"


#
# Set StartupWMClass
#
echo
echo
echo "Set WM_CLASS: "
echo "Default value is $APP_NAME"
echo "Use \`xprop WM_CLASS\` on the running app to find out; take the second value"
read -rp "Enter your value: " WMCLASS
WMCLASS=${WMCLASS:-$APP_NAME}


#
# Sandbox
#
echo
echo
echo "Do you want to disable sandbox? This is sometimes necessary if you run into 'SUID sandbox helper binary' errors."
read -rp "(yes/no): " ANSWER
case "$ANSWER" in
    [Yy]*) DISABLE_SANDBOX=" --no-sandbox";;
    *) DISABLE_SANDBOX=""
esac


#
# Create desktop file
#
APPIMAGE_FULLPATH_ESC_SPACES="${APPIMAGE_FULLPATH// /\\ }"

cat <<EOT > "$DESKTOP_ENTRY_PATH"
[Desktop Entry]
Name=$APP_NAME
Exec=$APPIMAGE_FULLPATH_ESC_SPACES$DISABLE_SANDBOX
Icon=$ICON_DST
StartupWMClass=$WMCLASS
Type=Application
Terminal=false
EOT

echo
echo
echo "Created $DESKTOP_ENTRY_PATH"
