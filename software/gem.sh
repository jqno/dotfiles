#!/usr/bin/env bash

GEM="gem"
if [ "$(uname -s)" == "Darwin" ]; then
  GEM="/usr/local/opt/ruby/bin/gem"
fi

# Built-in gem won't install globally, and brew refuses to replace its version with the built-in one: let's call it directly.
$GEM install bundler
$GEM install jekyll
$GEM install github-pages

