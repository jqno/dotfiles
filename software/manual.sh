#!/usr/bin/env bash

BIN="$HOME/bin"
rm -rf $BIN
mkdir $BIN


# Powerlevel10k
echo "** Installing Powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $BIN/powerlevel10k


# Java toolchain
echo "** Installing Java toolchain"
curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash -s -- --skip-rc && . ~/.jabba/jabba.sh
[ -s "$JABBA_HOME/jabba.sh" ] && source "$JABBA_HOME/jabba.sh"
jabba install adopt@1.8.0-292
jabba install adopt@1.11.0-11


# Java-debug
echo "** Installing java-debug"
pushd $BIN > /dev/null
git clone https://github.com/microsoft/java-debug.git
cd java-debug
./mvnw clean install -DskipTests
popd > /dev/null


# VSCode-java-test
echo "** Installing vscode-java-test"
pushd $BIN > /dev/null
git clone https://github.com/microsoft/vscode-java-test.git
cd vscode-java-test
npm install
npm run build-plugin
popd > /dev/null


# Coursier
echo "** Installing Coursier"
pushd $BIN > /dev/null
curl -fLo cs https://git.io/coursier-cli-"$(uname | tr LD ld)"
chmod +x cs
popd > /dev/null

