#!/usr/bin/env bash
# shellcheck disable=SC2164,SC1091

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"


# Manual tools
BIN="$HOME/bin"
rm -rf "$BIN"
mkdir "$BIN"


# Fonts
echo "*** Installing fonts"
mkdir "$HOME/.fonts"
pushd "$HOME/.fonts" > /dev/null
curl -L -o symbolsonly.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip
unzip -j symbolsonly.zip "*.ttf"
rm symbolsonly.zip
curl -L -o juliamono.zip https://github.com/cormullion/juliamono/releases/latest/download/JuliaMono.zip
unzip -j juliamono.zip "*.ttf"
rm juliamono.zip
popd > /dev/null


# SDKMAN
echo "*** Installing SDKMAN"
curl -s "https://get.sdkman.io?rcupdate=false" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"


# JBang/Scala/Kotlin/Kscript
sdk install jbang
sdk install scala
sdk install kotlin
sdk install kscript


# JDT.LS
echo "*** Installing Lombok for jdt.ls"
mkdir "$BIN/jdtls"
curl -L -o "$BIN/jdtls/lombok.jar" https://projectlombok.org/downloads/lombok.jar


# Vale Alex and Proselint styles
echo "*** Installing some styles for Vale linter"
rm -rf ~/.vale
mkdir -p ~/.vale/sources
pushd ~/.vale > /dev/null

git clone https://github.com/errata-ai/alex sources/alex
ln -s sources/alex/alex alex
git clone https://github.com/errata-ai/proselint sources/proselint
ln -s sources/proselint/proselint proselint
rm proselint/Annotations.yml # Let's allow words like NOTE, TODO and FIXME

popd > /dev/null
