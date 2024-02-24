# dotconf

This is a very basic script which can help you organise your dotfiles/configs accross platforms.

Before using the script, you have to write which files/directories you want to copy into the `files` array. If more than one files/directories have the same last word (i.e. /config/nvim & /home/nvim) this will crash the script.

Also you shouldn't add trailing slash to the directories/files.

## Usage
./dotconf.sh pull # This will copy files/directories into the dotconf's directory

./dotconf.sh push # This will copy files/directories into the directory you chose


