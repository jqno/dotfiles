# SERVER="dekluis"
SERVER="192.168.178.30"

rsync --progress -e "ssh -c aes256-cbc -o IdentitiesOnly=yes" --iconv=UTF-8-MAC,UTF-8 --delete -av --exclude ".DS_Store" --exclude ".fseventsd" --exclude ".Spotlight-V100" --exclude ".TemporaryItems" --exclude ".Trashes" --exclude "*.photoslibrary" --exclude "@eaDir" jqno@$SERVER:/volume1/photos /Volumes/files

