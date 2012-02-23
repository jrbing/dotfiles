# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.dotfiles/zsh/oh-my-zsh

# Set to the name theme to load.
export ZSH_THEME="robbyrussell"
#export ZSH_THEME="sunrise"

# Disable auto updates
DISABLE_AUTO_UPDATE="true"

# Oh-my-zsh plugins
plugins=(vi-mode history-substring-search git ruby brew bundler gem github osx rails thor git-flow heroku rvm )

# Use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

#Source aliases
source $HOME/.dotfiles/zsh/aliases.sh

#Source functions
source $HOME/.dotfiles/zsh/functions.sh

export DOTFILES=~/.dotfiles

fpath=($DOTFILES/zsh/zsh-completions $fpath)

# Source z.sh
. ~/.dotfiles/zsh/z/z.sh
    function precmd () {
      _z --add "$(pwd -P)"
    }

# Editor and PATH settings
# export JRUBY_OPTS=--1.9
export EDITOR=vim
export PATH=$PATH:~/.bin
export PATH=$PATH:~/.dotfiles/bin
export PATH=/usr/local/bin:$PATH

# Set colors for ls
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# Load RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Load Tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
