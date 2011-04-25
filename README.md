# My Personal dotfiles #

## Installation ##

1. Clone the repository
    * cd ~
    * git clone git@github.com:jrbing/dotfiles.git .dotfiles
2. Create symlinks
    * Unix: run bootstrap.sh
    * Windows: run bootstrap.bat

## VIM ##
Most of the settings within my vimrc and gvimrc have been borrowed from
Janus and other sources.

### VIMRC Settings ###
Notable vimrc settings.

Setup:

* default encoding set to UTF-8
* Whitespace settings
    * wrapping is turned off
    * tabs set to 2 spaces
* Markdown
    * tabs set to 4 spaces
* default to real tabs for python and make
* document is automatically saved when focus is lost

Key-Mappings:

* mapleader is set to ,
* semicolon is mapped to colon in normal mode
* <leader>e - opens an edit command with the path of the currently
  edited file
* <leader>te - opens a tab edit with the path of the currently edited
  file
* <Ctrl>P - inserts the path of the currently edited file in command
  mode
* <Ctrl>Up/Down - bubbles single or multiple lines
* <leader>v - reselect the text that was previously pasted
* <Ctrl>j/k/h/l - move down, up, left, and right among splits

### GVIMRC Settings ###

Configuration:

Key Mappings:

Windows Specific:

* Configuration
    * Font set to Consolas, 11 points
    * viminfo file is saved to user home directory
    * NERDTreeBookmarksFile is saved to users home directory
    * tab line is shown
    * open maximized
    * prevent vim from writing backups due to issues with home directory
      being set to a network share
    * the mswin.vim file is sourced to allow default windows save,
      print, paste commands to be used
* Key Mappings
    * <Alt>F - toggle Ack
    * <Alt>P - run the current file through markdown2pdf to a temp
      directory and open the output

OSX Specific:

* Configuration
* Key Mappings
    * <Command>t - open CommandT
    * <Command>return - fullscreen
    * <Command>F - toggle Ack
    * <Command>e - run ConqueTerm
    * <Command>/ - toggle comments
    * <Command>]/[ - increase/decrease indentation
    * <Command>number - switch tab tab number

### Plugins ###
Plugins used, along with frequently used default and custom keymappings.

* ack
* align
* commandt
    * Maximum height set to 20 rows
* conque
* easymotion
    * leader key for this is mapped to '\'
* futigive
* git
* indent_object
* markdown
* markdown_preview
* nerdcommenter
* nerdtree
    * NERDTreeToggle set to <Leader>n
* pathogen
* rails
* searchfold
* snipmate
* solarized
* supertab
* surround
* taglist
* taskpaper
* unimpaired
* voom
* zoomwin
    * default set to <Leader><Leader>

## ZSH ##


## TMUX ##

## Quix ##
