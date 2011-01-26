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

Unix:
    ln -s ~/.dotfiles/vimrc.local ~/.vimrc.local
    ln -s ~/.dotfiles/gvimrc.local ~/.gvimrc.local
    ln -s ~/.dotfiles/bash_profile ~/.bash_profile
    ln -s ~/.dotfiles/bashrc ~/.bashrc

