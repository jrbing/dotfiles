# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.dotfiles/zsh/oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(vi-mode history-substring-search git ruby brew bundler gem github osx rails thor cloudapp git-flow heroku pow powder rvm )

source $ZSH/oh-my-zsh.sh
alias tx=tmuxinator

# Load RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Load Tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# export JRUBY_OPTS=--1.9
export EDITOR=vim
export PATH=$PATH:~/.bin
export PATH=$PATH:~/.dotfiles/bin

# Source z.sh
. ~/.dotfiles/zsh/z/z.sh
    function precmd () {
      _z --add "$(pwd -P)"
    }

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi
