#!/usr/bin/env bash

export DOTFILES=$HOME/.dotfiles

# Use .localrc for settings specific to one system
if [[ -f $HOME/.localrc ]]; then
  source $HOME/.localrc
fi

# OS Specific Settings
case $(uname) in
  (Darwin)
    source $DOTFILES/env/darwinrc
  ;;
  (Linux)
    source $DOTFILES/env/linuxrc
  ;;
  (SunOS)
    source $DOTFILES/env/solarisrc
  ;;
  (CYGWIN*)
    source $DOTFILES/env/msysrc
  ;;
esac

# Aliases
alias ..='cd ..'
alias ls="ls -F"
alias l="ls -lAh"
alias ll="ls -l"
alias la='ls -A'

export EDITOR=vim
export JRUBY_OPTS=--1.9

eval "$($HOME/.dotfiles/bin/consigliere init -)"

# Additional sourcing
source $DOTFILES/bash/bash_prompt.sh
source $DOTFILES/bash/man_colors.sh

export PATH=$PATH:$DOTFILES/bin       # Add scripts to PATH
export SQLPATH=$DOTFILES/sql/oracle   # SQL script path for sqlplus

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # Load RVM
PATH=$PATH:$HOME/.rvm/bin                                             # Add RVM to PATH for scripting
