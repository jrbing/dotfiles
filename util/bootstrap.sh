#!/usr/bin/env bash
# Create symlinks for dotfiles

#TODO:  add a function to clean this mess up
ln -s ~/.dotfiles/ackrc ~/.ackrc
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
ln -s ~/.dotfiles/vim/gvimrc ~/.gvimrc
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/bash_profile ~/.bash_profile
ln -s ~/.dotfiles/bashrc ~/.bashrc
ln -s ~/.dotfiles/zshrc ~/.zshrc
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/sqlplus_completions ~/.sqlplus_completions
ln -s ~/.dotfiles/wrkrc ~/.localrc
ln -s ~/.dotfiles/zsh/dircolors-solarized/dircolors.ansi-universal ~/.dir_colors
