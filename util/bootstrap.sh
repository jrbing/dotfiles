#!/usr/bin/env zsh

DOTFILES=$HOME/.dotfiles
BASE_FILES=( "ackrc" "bash_profile" "bashrc" "gemrc" "gitconfig" "gitignore" "profile" "sqlplus_completions" "tmux.conf" "zprofile" "zshrc" "wgetrc")

createBaseSymlinks () {
for i in ${BASE_FILES[@]}
do

  if [ -f ~/.${i} ] || [ -h ~/.${i} ]
    then
      echo "Found ~/.${i}... Backing up to ~/.${i}.old";
      cp ~/.${i} ~/.${i}.old;
      rm ~/.${i};
  fi

  echo "Creating alias for ${i}"
  ln -s ${DOTFILES}/${i} ~/.${i}

done
}

createSymlinks

ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
ln -s ~/.dotfiles/vim/gvimrc ~/.gvimrc
ln -s ~/.dotfiles/vim ~/.vim

