# Dotfiles

This repository contains my dotfiles. 🎉

## Disclaimer

These dotfiles set things up the way I like things. Please copy everything that seems useful to you!

## Installation

This repo uses GNU Stow under the hood to manage the dotfiles.

To install on a clean machine:

* Clone this repo.
* Run `./install.sh`.

If installing the software fails at some point, you can safely re-try: the operation is idempotent.

To remove the dotfiles, run `./clean.sh`.

**NOTE**: Unfortunately, this is not an unattended install: you have to stick around to enter your password or confirm things every once in a while. Also, you may need to wait a long time, because some things (looking at you, Xcode) take a looooong time to install.
