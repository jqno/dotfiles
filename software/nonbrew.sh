#!/usr/bin/env bash

npm install -g prettier prettier-plugin-java
npm install -g @fsouza/prettierd
npm install --prefix "$(npm root -g)"/@fsouza/prettierd prettier-plugin-java

/usr/bin/pip3 install requests

# For ulauncher
/usr/bin/pip3 install --user dateparser jinja2 python-frontmatter markdown
