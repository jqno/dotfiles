FROM="$(pwd)/iterm2"
TO="$HOME/.iterm2"
rm -rf $TO 2> /dev/null
ln -s $FROM $TO

# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.iterm2"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
# Tell iTerm2 to save preferences to the directory on quit
defaults write com.googlecode.iterm2.plist NoSyncNeverRemindPrefsChangesLostForFile -bool true
defaults write com.googlecode.iterm2.plist NoSyncNeverRemindPrefsChangesLostForFile_selection -int 0

