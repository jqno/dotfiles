#!/usr/bin/env bash

npm install -g prettier@2.8.8 prettier-plugin-java@2.2.0
npm install -g @fsouza/prettierd
npm install --prefix "$(npm root -g)"/@fsouza/prettierd prettier-plugin-java

/usr/bin/pip3 install requests

# For ulauncher
/usr/bin/pip3 install --user dateparser jinja2 python-frontmatter markdown
