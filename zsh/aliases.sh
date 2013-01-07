#!/usr/bin/env zsh

# Aliases
alias rsync="rsync -avz"
alias ..='cd ..'
alias ls="ls -F"
alias l="ls -lAh"
alias ll="ls -l"
alias la='ls -A'
alias server="open http://localhost:4567 && ruby -e '"'require "rack"; Rack::Handler::Thin.run(Rack::Directory.new("."), :Port => 4567)'"'"
