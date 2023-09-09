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
curl -L -o firacode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip
unzip -j firacode.zip "*.ttf"
rm firacode.zip
curl -L -o cascadiacode.zip https://github.com/microsoft/cascadia-code/releases/download/v2111.01/CascadiaCode-2111.01.zip
unzip -j cascadiacode.zip "ttf/CascadiaCodePL*"
rm cascadiacode.zip
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


# Java-debug
echo "*** Installing java-debug"
pushd "$BIN" > /dev/null
git clone https://github.com/microsoft/java-debug.git
cd java-debug
./mvnw clean install -DskipTests
popd > /dev/null


# VSCode-java-test
echo "*** Installing vscode-java-test"
pushd "$BIN" > /dev/null
git clone https://github.com/microsoft/vscode-java-test.git
cd vscode-java-test
npm install
npm run build-plugin
popd > /dev/null


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
