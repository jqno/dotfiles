This repository contains my dotfiles. 🎉

# Disclaimer

These dotfiles set things up the way I like things. Please copy everything that seems useful to you!

# Contents

* Ctags
* Hammerspoon
* IdeaVim, attempting to mirror Vim config as much as possible
* Karabiner
* KiTTY
* Tig
* Vim, using vim-plug
* Zsh, without oh-my-zsh or similar package manager
* All of the softwares, using Brew, npm, Gem and Pip
* Automated install for each of these

# Installation

To install on a clean machine:

* Run `git` so the Xcode command line developer tools get installed.
* Clone this repo.
* Run `./install.sh`.

If installing the software fails at some point, you can safely re-try: the operation is idempotent.

**NOTE**: Unfortunately, this is not an unattended install: you have to stick around to enter your password or confirm things every once in a while. Also, you may need to wait a long time, because some things (looking at you, Xcode) take a looooong time to install.

