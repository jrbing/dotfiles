# My dotfiles #

-------------------

## Installation ##

### Clone the repository ###

    cd ~
    git@github.com:jrbing/dotfiles.git .dotfiles

### Create symlinks ###

Windows: 
    mklink /H "C:\Program Files\Vim\_vimrc" "C:\Program Files\Vim\.dotfiles\vimrc"
    mklink /H "C:\Program Files\Vim\_gvimrc" "C:\Program Files\Vim\.dotfiles\gvimrc"
    mklink /D "C:\Program Files\Vim\vimfiles" "C:\Program Files\Vim\.dotfiles\vim"

Unix:
    ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
    ln -s ~/.dotfiles/vim/gvimrc ~/.gvimrc
    ln -s ~/.dotfiles/vim ~/.vim
    ln -s ~/.dotfiles/bash_profile ~/.bash_profile
    ln -s ~/.dotfiles/bashrc ~/.bashrc

