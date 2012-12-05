#!/usr/bin/env bash

export DOTFILES=$HOME/.dotfiles

# Use .localrc for settings specific to one system
if [[ -f $HOME/.localrc ]]; then
  source $HOME/.localrc
fi

# Aliases
alias ..='cd ..'
alias ls="ls -F"
alias l="ls -lAh"
alias ll="ls -l"
alias la='ls -A'

export EDITOR=vim
export JRUBY_OPTS=--1.9

source $DOTFILES/lib/bash_prompt.bash

export PATH=$PATH:$DOTFILES/bin       # Add paths
export SQLPATH=$DOTFILES/sql/oracle

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # Load RVM
PATH=$PATH:$HOME/.rvm/bin                                             # Add RVM to PATH for scripting
