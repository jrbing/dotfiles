# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.dotfiles/zsh/oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="robbyrussell"
#export ZSH_THEME="sunrise"

# Disable auto updates
DISABLE_AUTO_UPDATE="true"

# Oh-my-zsh plugins
plugins=(vi-mode history-substring-search git ruby brew bundler gem github osx rails thor git-flow heroku rvm )

source $ZSH/oh-my-zsh.sh

# Editor and PATH settings
# export JRUBY_OPTS=--1.9
export EDITOR=vim
export PATH=$PATH:~/.bin
export PATH=$PATH:~/.dotfiles/bin
export PATH=/usr/local/bin:$PATH

# Set colors for ls
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# Source z.sh
. ~/.dotfiles/zsh/z/z.sh
    function precmd () {
      _z --add "$(pwd -P)"
    }

# Use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

# Load RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Load Tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# Function to search for running processes
any() {
    emulate -L zsh
    unsetopt KSH_ARRAYS
    if [[ -z "$1" ]] ; then
        echo "any - grep for process(es) by keyword" >&2
        echo "Usage: any " >&2 ; return 1
    else
        ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
    fi
}
