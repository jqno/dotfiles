#!/usr/bin/env bash

LIGATURES="-> === != www"
NERDSYMBOLS="契           勒 鈴 "
FONTCONFIG="zero:0 ss02:<= ss03:& ss04:\$ ss07: =~ cv14:3 ss10:fl"
SYMBOLS="$NERDSYMBOLS     $LIGATURES     $FONTCONFIG"

kitty +list-fonts --psnames

echo ""
echo ""
echo ""
echo -e "  Name        Nerd symbols                  Ligatures         Font config (Fira Code)"
echo -e "* Regular     $SYMBOLS"
echo -e "* \033[1mBold        $SYMBOLS\033[0m"
echo -e "* \033[3mItalic      $SYMBOLS\033[0m"
echo -e "* \033[1m\033[3mBold Italic $SYMBOLS\033[0m"
echo -e "* \033[4mUnderline   $SYMBOLS\033[0m"
echo -e "* \033[4:3mUndercurl   $SYMBOLS\033[0m"
