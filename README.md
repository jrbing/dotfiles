# My dotfiles #

-------------------

## Installation ##

### Clone the repository ###

    cd ~
    git clone git@github.com:jrbing/dotfiles.git .dotfiles

### Create symlinks ###

Unix:
    sh bootstrap.sh

Windows:
    mklink /H "C:\Program Files\Vim\_vimrc" "C:\Program Files\Vim\.dotfiles\vimrc"
    mklink /H "C:\Program Files\Vim\_gvimrc" "C:\Program Files\Vim\.dotfiles\gvimrc"
    mklink /D "C:\Program Files\Vim\vimfiles" "C:\Program Files\Vim\.dotfiles\vim"
