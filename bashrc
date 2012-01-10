#!/usr/bin/env sh

# ALIASES
alias ..='cd ..'
alias ls="ls -F"
alias l="ls -lAh"
alias ll="ls -l"
alias la='ls -A'

export EDITOR=vim
. ~/.dotfiles/bin/bash_colors.sh

# Add paths
export PATH=$PATH:~/.bin
export PATH=$PATH:~/.dotfiles/bin

# Load RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Source z.sh
. ~/.dotfiles/zsh/z/z.sh

# Use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

