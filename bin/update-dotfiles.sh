#!/bin/sh
#Refresh dotfiles from repo and update submodules
cd ~/.dotfiles

# Pull down updates to dotfiles from github
echo 'Updating dotfiles from github...'
git pull origin master

# Update submodules
echo 'Updating plugins...'
git submodule init
git submodule update
#git submodule foreach git checkout master
#git submodule foreach git pull origin master

# Show submodule status
git submodule status
