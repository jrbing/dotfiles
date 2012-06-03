#!/usr/bin/env zsh

DOTFILES=$HOME/.dotfiles
BASE_FILES=( "bash_profile" "bashrc" "profile" "zprofile" "zshrc")
ETC_FILES=("ackrc" "gemrc" "sqlplus_completions" "tmux.conf" "wgetrc")
GIT_FILES=("gitconfig" "gitignore")
VIM_FILES=("vimrc" "gvimrc" "vim")

createBaseSymlinks () {
for i in ${BASE_FILES[@]}
do
  if [ -f ~/.${i} ] || [ -h ~/.${i} ]
    then
      printf "Found ~/.${i}... Backing up to ~/.${i}.old\n";
      cp ~/.${i} ~/.${i}.old;
      rm ~/.${i};
  fi
  printf "Creating alias for ${i}\n"
  ln -s ${DOTFILES}/${i} ~/.${i}
done
}

createEtcSymlinks () {
for i in ${ETC_FILES[@]}
do
  if [ -f ~/.${i} ] || [ -h ~/.${i} ]
    then
      printf "Found ~/.${i}... Backing up to ~/.${i}.old\n";
      cp ~/.${i} ~/.${i}.old;
      rm ~/.${i};
  fi
  printf "Creating alias for ${i}\n"
  ln -s ${DOTFILES}/etc/${i} ~/.${i}
done
}

createGitSymlinks () {
for i in ${BASE_FILES[@]}
do
  if [ -f ~/.${i} ] || [ -h ~/.${i} ]
    then
      printf "Found ~/.${i}... Backing up to ~/.${i}.old\n";
      cp ~/.${i} ~/.${i}.old;
      rm ~/.${i};
  fi
  printf "Creating alias for ${i}\n"
  ln -s ${DOTFILES}/${i} ~/.${i}
done
}

createVimSymlinks () {
for i in ${BASE_FILES[@]}
do
  if [ -f ~/.${i} ] || [ -h ~/.${i} ]
    then
      printf "Found ~/.${i}... Backing up to ~/.${i}.old\n";
      cp ~/.${i} ~/.${i}.old;
      rm ~/.${i};
  fi
  printf "Creating alias for ${i}\n"
  ln -s ${DOTFILES}/${i} ~/.${i}
done
}

createBaseSymlinks
createEtcSymlinks
createGitSymlinks
createVimSymlinks

printf "Copying ssh_default settings...\n"
cp $DOTFILES/etc/ssh_config $HOME/.ssh/config

