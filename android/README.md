# Install on Android

1. Install Termux from F-Droid store (the one in Play Store is broken)
2. Long-press on the screen, select More, select Style, and install FiraCode font
3. Run `termux-setup-storage`
4. Run `pkg install git openssh stow`
5. Download GitHub SSH keys from Bitwarden
6. Move them: `mv storage/downloads/id_* ~/.ssh`
7. Run `chmod 600 ~/.ssh/id_*`
8. Run `git clone git@github.com:jqno/dotfiles.git`
9. Run `os-specific/android/install.sh`
10. Run `./install.sh`, but don't install software
11. Go crazy
