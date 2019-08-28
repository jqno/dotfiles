#!/usr/bin/env sh

# Built-in gem won't install globally, and brew refuses to replace its version with the built-in one: let's call it directly.
/usr/local/opt/ruby/bin/gem install jekyll
/usr/local/opt/ruby/bin/gem install github-pages

