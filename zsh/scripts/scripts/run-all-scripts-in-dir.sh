# Add the following line to ~/.bashrc or ~/.zshrc:
# . /path/to/this/script/run.sh script_folder
# For example:
# . ./run-all-scripts-in-dir.sh ~/.zsh/scripts
# Don't forget the dot!

for f in $1/*; do
   . $f
done
