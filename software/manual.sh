#!/usr/bin/env bash
# shellcheck disable=SC2164,SC1091

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"


# Manual tools
BIN="$HOME/bin"
rm -rf "$BIN"
mkdir "$BIN"


# SDKMAN
echo "*** Installing SDKMAN"
curl -s "https://get.sdkman.io?rcupdate=false" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk install maven
sdk install mvnd
sdk install jbang

sdk install scala
sdk install sbt
sdk install kotlin
sdk install kscript


# Coursier
curl -fL "https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz" | gzip -d > "$BIN/cs"
chmod +x "$BIN/cs"
"$BIN/cs" setup -y
"$BIN/cs" install scalafix


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
