#!/usr/bin/env zsh
# ZSH settings file

# OH-MY-ZSH settings
export DOTFILES=$HOME/.dotfiles
export ZSH=$DOTFILES/zsh/oh-my-zsh    #Path to oh-my-zsh configuration.
#export ZSH_THEME="robbyrussell"      #Theme
#export ZSH_THEME="sammy"             #Theme
export ZSH_THEME="sorin"              #Theme
DISABLE_AUTO_UPDATE="true"            #Disable auto updates

# OS Specific Settings
case $(uname) in
  (Darwin)
    plugins=( vi-mode history-substring-search ruby brew gem thor git-flow rvm ) # oh-my-zsh plugins
    export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD # Set colors for ls
    #source $DOTFILES/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  # zsh-syntax-highlighting
    alias vim='mvim -v'
    export PATH=/usr/local/bin:/usr/local/sbin:$PATH  # Necessary for homebrew
  ;;
  (Linux)
    plugins=( vi-mode ) # oh-my-zsh plugins
    export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD # Set colors for ls
  ;;
  (SunOS)
    plugins=( vi-mode gnu-utils ) # oh-my-zsh plugins
    source $DOTFILES/env/solarisrc
  ;;
  (CYGWIN*)
    source $DOTFILES/env/msysrc
  ;;
esac

# Use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

# Sourcing
source $ZSH/oh-my-zsh.sh           # Source oh-my-zsh
source $DOTFILES/zsh/aliases.sh    # Source aliases
source $DOTFILES/zsh/functions.sh  # Source functions

# Editor and PATH settings
export EDITOR=vim
export PAGER=less
export PATH=$PATH:$HOME/.dotfiles/bin

# Additional 3rd party stuff
fpath=($DOTFILES/zsh/zsh-completions $fpath)  #ZSH completion

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM
PATH=$PATH:$HOME/.rvm/bin                                            # Add RVM to PATH for scripting

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator # Tmuxinator

PATH=$PATH:$DOTFILES/zsh/fasd # Add fasd to PATH
eval "$(fasd --init auto)"

