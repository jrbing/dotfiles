# My Personal Dotfiles #
Most likely not useful to anyone other than myself.  Originally posted here as a way to synchronize my settings across multiple machines.  

## Installation ##

1. Clone the repository
    * cd ~
    * git clone git@github.com:jrbing/dotfiles.git .dotfiles
2. Create symlinks
    * Unix: run bootstrap.sh
    * Windows: run bootstrap.bat

## VIM ##
Most of these have been borrowed from Janus and other sources before being subsequently modified/mangled.  

### VIMRC Settings ###
Notable vimrc settings.

**Setup:**

* Default encoding set to UTF-8
* Whitespace settings
    * wrapping is turned off
    * tabs set to 2 spaces
* Markdown
    * tabs set to 4 spaces
* Default to real tabs for python and make
* Document is automatically saved when focus is lost

**Key-Mappings:**

    mapleader is set to ,
    semicolon is mapped to colon in normal mode
    <leader>e - opens an edit command with the path of the currently edited file
    <leader>te - opens a tab edit with the path of the currently edited file
    <Ctrl>P - inserts the path of the currently edited file in command
    <leader>v - reselect the text that was previously pasted mode
    <Ctrl>Up/Down - bubbles single or multiple lines
    <Ctrl>j/k/h/l - move down, up, left, and right among splits

### GVIMRC Settings ###

#### Windows Specific ####

**Configuration**

* Font set to Consolas, 11 points
* viminfo file is saved to user home directory
* NERDTreeBookmarksFile is saved to users home directory
* tab line is shown
* gvim window is set to open maximized
* prevent vim from writing backups due to issues with home directory
  being set to a network share
* the mswin.vim file is sourced to allow default windows save,
  print, paste commands to be used

**Key Mappings**

    <Alt>F - toggle Ack
    <Alt>P - run the current file through markdown2pdf to a temp directory and open the output

#### OSX Specific ####

**Key Mappings**

    <Command>t - open CommandT
    <Command>return - fullscreen
    <Command>F - toggle Ack
    <Command>e - run ConqueTerm
    <Command>/ - toggle comments
    <Command>]/[ - increase/decrease indentation
    <Command>number - switch tab tab number

### Plugins ###
Plugins used, along with frequently used default and custom keymappings.

#### Ack ####
Plugin that integrates Ack with VIM.

* Custom keymappings
    * Windows
        * Alt+Shift+f > toggle ACK
    * OSX
        * Command+Shift+f > toggle ACK

#### Align ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK

#### Command-t ####
Description of the plugin. 

#### Conque ####
Description of the plugin. 

#### EasyMotion ####
Description of the plugin. 

#### Fugitive ####
Description of the plugin. 

#### Git ####
Description of the plugin. 

### Indent Object ####
Description of the plugin. 

#### Markdown Preview ####
Description of the plugin. 

#### NERD Commenter ####
Description of the plugin. 

#### NERD Tree ####
Description of the plugin. 

#### Rails ####
Description of the plugin. 

#### Searchfold ####
Description of the plugin. 

#### Snipmate ####
Description of the plugin. 

#### Solarized ####
Description of the plugin. 

#### Supertab ####
Description of the plugin. 

#### Surround ####
Description of the plugin. 

#### Taglist ####
Description of the plugin. 

#### Taskpaper ####
Description of the plugin. 

#### Unimpaired ####
Description of the plugin. 

#### Voom ####
Description of the plugin. 

#### Zoomwin ####
Description of the plugin. 

## ZSH ##

## TMUX ##

## Quix ##
