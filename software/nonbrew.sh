#!/usr/bin/env bash

npm install -g prettier prettier-plugin-java@2.4.0
npm install -g @fsouza/prettierd
npm install --prefix "$(npm root -g)"/@fsouza/prettierd prettier-plugin-java@2.4.0

/usr/bin/pip3 install requests
