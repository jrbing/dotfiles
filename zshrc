#!/usr/bin/env zsh
# ZSH settings file

# oh-my-zsh settings
export DOTFILES=$HOME/.dotfiles
export ZSH=$DOTFILES/zsh/oh-my-zsh    #Path to oh-my-zsh configuration.
export ZSH_THEME="robbyrussell"       #Theme
DISABLE_AUTO_UPDATE="true"            #Disable auto updates
plugins=( vi-mode history-substring-search ruby brew bundler gem thor git-flow rvm ) # oh-my-zsh plugins

# Use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

# Sourcing
source $ZSH/oh-my-zsh.sh                 # Source oh-my-zsh
source $DOTFILES/zsh/aliases.sh    # Source aliases
source $DOTFILES/zsh/functions.sh  # Source functions

# Completion
fpath=($DOTFILES/zsh/zsh-completions $fpath)  #ZSH completion

# Editor and PATH settings
export EDITOR=vim
export PAGER=less
export PATH=$PATH:$HOME/.dotfiles/bin
#export PATH=$PATH:$HOME/.bin
#export PATH=/usr/local/bin:$PATH
#export PATH=$HOME/bin:$PATH

# OS Specific Settings
case $(uname) in
  (Darwin)
    export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD # Set colors for ls
  ;;
  (Linux)
    export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD # Set colors for ls
  ;;
  (SunOS)
    source $DOTFILES/env/solarisrc
  ;;
esac

# Additional 3rd party stuff
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM
PATH=$PATH:$HOME/.rvm/bin                                            # Add RVM to PATH for scripting

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator # Tmuxinator

PATH=$PATH:$DOTFILES/zsh/fasd # Add fasd to PATH
eval "$(fasd --init auto)"

source $DOTFILES/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  #zsh-syntax-highlighting
