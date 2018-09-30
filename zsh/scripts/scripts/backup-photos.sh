
FOLDER=2018

# rsync --dry-run -e "ssh -c aes256-cbc" --iconv=UTF-8-MAC,UTF-8 --delete -av --exclude ".DS_Store" --exclude ".fseventsd" --exclude ".Spotlight-V100" --exclude ".TemporaryItems" --exclude ".Trashes" --exclude "*.photoslibrary" --exclude "@eaDir" /Volumes/Backup/photos/$FOLDER jqno@dekluis:/volume1/photos
# rsync --progress -e "ssh -c aes256-cbc" --iconv=UTF-8-MAC,UTF-8 --delete -av --exclude ".DS_Store" --exclude ".fseventsd" --exclude ".Spotlight-V100" --exclude ".TemporaryItems" --exclude ".Trashes" --exclude "*.photoslibrary" --exclude "@eaDir" /Volumes/Backup/photos/$FOLDER jqno@192.168.0.103:/volume1/photos
rsync --progress -e "ssh -c aes256-cbc" --iconv=UTF-8-MAC,UTF-8 --delete -av --exclude ".DS_Store" --exclude ".fseventsd" --exclude ".Spotlight-V100" --exclude ".TemporaryItems" --exclude ".Trashes" --exclude "*.photoslibrary" --exclude "@eaDir" /Volumes/Backup/photos/$FOLDER jqno@dekluis:/volume1/photos

