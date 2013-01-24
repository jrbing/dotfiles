#!/usr/bin/env zsh
# Aliases

############
# Filesystem
############

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

alias l='ls -lAh'
alias ls='ls -F'
alias ll='ls -l'
alias la='ls -A'

#############
# Development
#############

alias server="open http://localhost:4567 && ruby -e '"'require "rack"; Rack::Handler::Thin.run(Rack::Directory.new("."), :Port => 4567)'"'"

extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


##########
# Database
##########

alias pmons="ps -ef | grep pmon | grep -v grep | wc -l"

#####
# Git
#####

alias lg='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
alias m="git add .;git commit -m"
