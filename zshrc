#!/usr/bin/env zsh
# ZSH settings file

# OH-MY-ZSH settings
export DOTFILES=$HOME/.dotfiles
export ZSH=$DOTFILES/zsh/oh-my-zsh    #Path to oh-my-zsh configuration.
export ZSH_THEME="sorin"              #Theme
DISABLE_AUTO_UPDATE="true"            #Disable auto updates
unsetopt correct_all
export EDITOR=vim
export PAGER=less

# OS Specific Settings
case $(uname) in
  (Darwin)
    plugins=( vi-mode history-substring-search cp forklift ) # oh-my-zsh plugins
    source $DOTFILES/env/darwinrc
  ;;
  (Linux)
    plugins=( vi-mode ) # oh-my-zsh plugins
    source $DOTFILES/env/linuxrc
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
if [[ -f ~/.localrc ]]; then
  source ~/.localrc
fi

# Autoload
autoload zmv

# Sourcing
source $ZSH/oh-my-zsh.sh            # Source oh-my-zsh
source $DOTFILES/zsh/aliases.sh     # Source aliases
source $DOTFILES/zsh/functions.sh   # Source additional functions
source $DOTFILES/zsh/man_colors.sh  # Source color settings for man pages

# Consigliere
eval "$($HOME/.dotfiles/bin/consigliere init -)"

# Environment variable setup
export PATH=$PATH:$HOME/.dotfiles/bin
export SQLPATH="$DOTFILES/sql/oracle"

# 3rd party addons
fpath=($DOTFILES/zsh/zsh-completions $fpath)                                                 # ZSH completion
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"                         # RVM
PATH=$PATH:$HOME/.rvm/bin

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator # Tmuxinator

PATH=$PATH:$DOTFILES/zsh/fasd                                                                # FASD
eval "$(fasd --init auto)"

[[ -d /usr/local/heroku ]] && export PATH="/usr/local/heroku/bin:$PATH"                      # Heroku Toolbelt
