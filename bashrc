#!/usr/bin/env bash

# Use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

# ALIASES
alias ..='cd ..'
alias ls="ls -F"
alias l="ls -lAh"
alias ll="ls -l"
alias la='ls -A'

export EDITOR=vim
. ~/.dotfiles/lib/bash_colors.sh

# Add paths
export PATH=$PATH:~/.dotfiles/bin

# Load RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
