#!/usr/bin/env sh

mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

npm install --global chokidar chokidar-cli
npm install --global prettier@2.1.1 prettier-plugin-java@0.8.3
npm install --global typescript
npm install --global webpack webpack-cli

