#!/usr/bin/env sh

BIN="$HOME/bin"
rm -rf $BIN
mkdir $BIN

# Eclipse JDT Language Server
echo "** Installing Eclipse JDT Language Server"
ECLIPSE_JDT_LS_SOURCE="http://download.eclipse.org/jdtls/milestones/0.43.0/jdt-language-server-0.43.0-201909181008.tar.gz"
ECLIPSE_JDT_LS_TARGET="$BIN/eclipse-jdt-ls"
mkdir $ECLIPSE_JDT_LS_TARGET
pushd $ECLIPSE_JDT_LS_TARGET > /dev/null
curl -o "archive.tar.gz" $ECLIPSE_JDT_LS_SOURCE
tar xf archive.tar.gz
rm archive.tar.gz
popd > /dev/null

# Scala Metals Language Server
echo "** Installing Scala Metals Language Server"
curl -L -o "$BIN/coursier" https://git.io/coursier
chmod +x "$BIN/coursier"
coursier bootstrap \
  --java-opt -Xss4m \
  --java-opt -Xms100m \
  --java-opt -Dmetals.client=vim-lsc \
  org.scalameta:metals_2.12:0.7.6 \
  -r bintray:scalacenter/releases \
  -r sonatype:snapshots \
  -o /usr/local/bin/metals-vim -f
