My dotfiles

-------------------

## Installation ##

### Clone the repository ###

    cd ~
    git clone git://github.com/jrbing/dotfiles.git

### Create symlinks ###

Unix:
    ln -s ~/.dotfiles/vimrc.local ~/.vimrc.local
    ln -s ~/.dotfiles/gvimrc.local ~/.gvimrc.local
    ln -s ~/.dotfiles/bash_profile ~/.bash_profile
    ln -s ~/.dotfiles/bashrc ~/.bashrc

# Notes #

## vimrc.local ##

* Leader Key is mapped to ,
* Tabs are set to 4 spaces
* Menu is enabled for tab completion
* F1 is remapped to the ESC key
* the ; key is remapped to : in normal mode

Issues:

* sourcing the custom markdown snippet file doesn't work

## gvimrc.local ##
Additional changes to the gvimrc file. 

## bash_profile ##

