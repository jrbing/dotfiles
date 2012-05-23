#!/usr/bin/env zsh
# ZSH settings file

# oh-my-zsh settings
export DOTFILES=~/.dotfiles
export ZSH=$DOTFILES/zsh/oh-my-zsh # Path to oh-my-zsh configuration.
export ZSH_THEME="robbyrussell" # Theme
DISABLE_AUTO_UPDATE="true" # Disable auto updates
plugins=(vi-mode history-substring-search ruby brew bundler gem thor git-flow rvm ) # oh-my-zsh plugins

# Use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

# Sourcing
source $ZSH/oh-my-zsh.sh                 # Source oh-my-zsh
source $HOME/.dotfiles/zsh/aliases.sh    # Source aliases
source $HOME/.dotfiles/zsh/functions.sh  # Source functions

# Completion
fpath=($DOTFILES/zsh/zsh-completions $fpath)  #ZSH completion

# Editor and PATH settings
export EDITOR=vim
export PAGER=less
export PATH=$PATH:~/.bin
export PATH=$PATH:~/.dotfiles/bin
export PATH=/usr/local/bin:$PATH
export PATH=~/bin:$PATH

export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD # Set colors for ls

# Additional 3rd party stuff

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator # Tmuxinator

PATH=$PATH:$DOTFILES/zsh/fasd # Add fasd to PATH
eval "$(fasd --init auto)"

# OS Specific Settings
case $(uname) in
  (Darwin)
  #echo "This is OSX"
  ;;
esac
