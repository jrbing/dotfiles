# My Personal Dotfiles #

## Installation ##

1. Clone the repository
    * cd ~
    * git clone git@github.com:jrbing/dotfiles.git .dotfiles
2. Create symlinks
    * Unix: run bootstrap.sh
    * Windows: run bootstrap.bat

## VIM ##

### VIMRC Settings ###
Notable vimrc settings.

Setup:

* Default encoding set to UTF-8
* Whitespace settings
    * wrapping is turned off
    * tabs set to 2 spaces
* Markdown
    * tabs set to 4 spaces
* Default to real tabs for python and make
* Document is automatically saved when focus is lost

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

* Windows Specific:
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
* OSX Specific
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

#### Ack ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
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

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK

#### Conque ####

Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK

#### EasyMotion ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK

    * leader key for this is mapped to '\'
#### Fugitive ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK


#### Git ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK


#### Indent Object ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK


#### Markdown Preview ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK


#### NERD Commenter ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK


#### NERD Tree ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK

    * NERDTreeToggle set to <Leader>n

#### Rails ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK


#### Searchfold ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK


#### Snipmate ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK


#### Solarized ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK


#### Supertab ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK


#### Surround ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK


#### Taglist ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK


#### Taskpaper ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK


#### Unimpaired ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK


#### Voom ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK


#### Zoomwin ####
Description of the plugin. 

Default keymappings: 
* 

Custom keymappings: 
* Windows
    * Alt+Shift+f > toggle ACK
* OSX
    * Command+Shift+f > toggle ACK


* default set to <Leader><Leader>

## ZSH ##


## TMUX ##

## Quix ##
