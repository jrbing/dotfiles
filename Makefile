#===============================================================================
# vim: softtabstop=4 shiftwidth=4 noexpandtab fenc=utf-8 spelllang=en nolist
#===============================================================================
# curl https://raw.githubusercontent.com/jrbing/dotfiles/master/Makefile |make -f - all

BASH_FILES := $(shell ls bash)
ETC_FILES := $(shell ls etc)
GIT_FILES := $(shell ls git)
ZSH_FILES := $(shell ls zsh/z*)

#.PHONY: $(bash_files)
#.PHONY: $(etc_files)
#.PHONY: $(git_files)
#.PHONY: $(vim_files)

#$(bash_files):
	#test -e $(CURDIR)/$@ && ln $(LN_FLAGS) $(CURDIR)/$@ ~/.$@

#prezto:
	#test -d ~/.zprezto || \
		#git clone --quiet --recursive \
		#https://github.com/sorin-ionescu/prezto.git ~/.zprezto
	#ln $(LN_FLAGS) \
		#$(CURDIR)/zprezto/modules/prompt/functions/prompt_debian_setup \
		#~/.zprezto/modules/prompt/functions/prompt_debian_setup

# Maintenance
#check-dead:
	#find ~ -maxdepth 1 -name '.*' -type l -exec test ! -e {} \; -print

#clean-dead:
	#find ~ -maxdepth 1 -name '.*' -type l -exec test ! -e {} \; -delete

#update:
	#git pull --rebase


######################################################

#dotfiles=git://github.com/jrbing/dotfiles.git
#destination=~/.dotfiles

#all: clone link
#link: gemrc-link dir_colors-link tmux.conf-link vimrc-link bashrc-link zshrc-link
#pull: dotfiles-pull shellrc-pull vimrc-pull

# remove everything
#purge:
	#@rm -rf $(destination) ~/.gemrc ~/.dir_colors ~/.tmux.conf


# link simple files
#gemrc-link:
	#@cd && ln -sf $(destination)/gemrc .gemrc
#dir_colors-link:
	#@cd && ln -sf $(destination)/dir_colors .dir_colors
#tmux.conf-link:
	#@cd && ln -sf $(destination)/tmux.conf .tmux.conf

# link vim configuration
#vimrc-link:
	#@cd && ln -sf $(vimrc_dest)/vimrc .vimrc

# update repositories
#pull:
	#@cd $(destination) && git fetch origin master && git reset --hard FETCH_HEAD


all:
	@echo $(ZSH_FILES)

submodules:
	@git submodule foreach 'git fetch origin; git checkout master; git reset --hard origin/master; git submodule update --recursive; git clean -dfx'
