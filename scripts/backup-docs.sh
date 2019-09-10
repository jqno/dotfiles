
rsync --progress -e "ssh -c aes256-cbc" --iconv=UTF-8-MAC,UTF-8 --delete -av --exclude ".DS_Store" --exclude "._*" --exclude ".fseventsd" --exclude ".Spotlight-V100" --exclude ".TemporaryItems" --exclude ".Trashes" --exclude "@eaDir" /Volumes/EXTERNAL/documents/* jqno@dekluis:/volume1/documents
# rsync --progress -e "ssh -c aes256-cbc" --iconv=UTF-8-MAC,UTF-8 --delete -av --exclude ".DS_Store" --exclude "._*" --exclude ".fseventsd" --exclude ".Spotlight-V100" --exclude ".TemporaryItems" --exclude ".Trashes" --exclude "@eaDir" /Volumes/EXTERNAL/documents/* jqno@192.168.178.30:/volume1/documents

