#!/usr/bin/env bash

# Use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

# Aliases
alias ..='cd ..'
alias ls="ls -F"
alias l="ls -lAh"
alias ll="ls -l"
alias la='ls -A'

export EDITOR=vim
export JRUBY_OPTS=--1.9
. ~/.dotfiles/lib/bash_colors.sh
. ~/.dotfiles/lib/bash_prompt.sh

export PATH=$PATH:~/.dotfiles/bin # Add paths
export SQLPATH="~/.dotfiles/oracle/sql"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc" # Load pythonbrew
