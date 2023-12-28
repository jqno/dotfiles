#!/usr/bin/env bash

LIGATURES="-> === != www"
NERDSYMBOLS="        "
FONTCONFIG="cv07:0 cv08:f kerning:immi/mmmm"
SYMBOLS="$NERDSYMBOLS     $LIGATURES     $FONTCONFIG"

kitty +list-fonts --psnames

echo ""
echo ""
echo ""
echo -e "  Name        Nerd symbols      Ligatures         Font config (Commit Mono)"
echo -e "* Regular     $SYMBOLS"
echo -e "* \033[1mBold        $SYMBOLS\033[0m"
echo -e "* \033[3mItalic      $SYMBOLS\033[0m"
echo -e "* \033[1m\033[3mBold Italic $SYMBOLS\033[0m"
echo -e "* \033[4mUnderline   $SYMBOLS\033[0m"
echo -e "* \033[4:3mUndercurl   $SYMBOLS\033[0m"
