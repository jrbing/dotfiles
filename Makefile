#===============================================================================
# vim: softtabstop=4 shiftwidth=4 noexpandtab fenc=utf-8 spelllang=en nolist
#===============================================================================

dotfiles=~/.dotfiles

BASH_FILES := $(shell cd $(dotfiles)/bash; ls)
ETC_FILES := $(shell cd $(dotfiles)/etc; ls)
GPG_FILES := $(shell cd $(dotfiles)/gnupg; ls)
GIT_FILES := $(shell cd $(dotfiles)/git; ls)
ZSH_FILES := $(shell cd $(dotfiles)/zsh; ls z*)

all: help

link: link-tmux link-vim link-prezto link-etc link-git link-bash link-zsh link-gpg link-powershell  ## Link all dotfiles to their respective locations

link-tmux:
	@cd ~ && ln -nfs $(dotfiles)/tmux/oh-my-tmux/.tmux.conf .tmux.conf; \
				ln -nfs $(dotfiles)/tmux/tmux.conf.local .tmux.conf.local; \

link-vim:
	@cd ~ && ln -nfs $(dotfiles)/vim/ .vim; \
				ln -nfs $(dotfiles)/vim/vimrc .vimrc; \
				ln -nfs $(dotfiles)/vim/gvimrc .gvimrc

link-nvim:
	@cd ~ && ln -nfs $(dotfiles)/vim/ .config/nvim

link-prezto:
	@cd ~ && ln -nfs $(dotfiles)/zsh/prezto .zprezto

link-etc:
	@cd ~ && for file in $(ETC_FILES); do ln -nfs .dotfiles/etc/$$file .$$file; done

link-git:
	@cd ~ && for file in $(GIT_FILES); do ln -nfs .dotfiles/git/$$file .$$file; done

link-bash:
	@cd ~ && for file in $(BASH_FILES); do ln -nfs .dotfiles/bash/$$file .$$file; done

link-zsh:
	@cd ~ && for file in $(ZSH_FILES); do ln -nfs .dotfiles/zsh/$$file .$$file; done

link-gpg:
	@cd ~ && for file in $(GPG_FILES); do ln -nfs "$$HOME/.dotfiles/gnupg/$$file" "$$HOME/.gnupg/$$file"; done

link-launchd:
	@cd ~ && ln -nfs "$$HOME/.dotfiles/launchd/yosemite.pathfix.plist" "$$HOME/Library/LaunchAgents/yosemite.pathfix.plist"

link-cheat:
	@cd ~ && ln -nfs $(dotfiles)/cheat/ .cheat;

link-powershell:
	@cd ~ && ln -nfs $(dotfiles)/powershell/profile.ps1 ~/.config/powershell/profile.ps1;
	@cd ~ && ln -nfs $(dotfiles)/powershell/profile.ps1 ~/.config/powershell/Microsoft.PowerShell_profile.ps1;

link-vscode:
	@cd ~ && ln -nfs $(dotfiles)/vscode/macos-settings.json ~/Library/Application\ Support/Code/User/settings.json

link-pandoc:
	@cd ~ && ln -nfs $(dotfiles)/pandoc/ .pandoc

check-dead:  ## Check for dead symlinks
	@find ~ -maxdepth 1 -name '.*' -type l -exec test ! -e {} \; -print

clean-dead:  ## Cleanup dead symlinks
	@find ~ -maxdepth 1 -name '.*' -type l -exec test ! -e {} \; -delete

clean:  ## Remove all temporary and backup files
	@git clean -dfx

submodules:  ## Update all submodule references
	@git submodule foreach 'git fetch origin; \
			git checkout master; \
			git reset --hard origin/master; \
			git submodule update --recursive;'

iterm-integration:
	@curl -L https://iterm2.com/misc/bash_startup.in > $(dotfiles)/iterm/iterm2_shell_integration.bash; \
		curl -L https://iterm2.com/misc/zsh_startup.in > $(dotfiles)/iterm/iterm2_shell_integration.zsh; \
		curl -L https://raw.githubusercontent.com/gnachman/iTerm2/master/tests/imgcat > $(dotfiles)/iterm/imgcat

update:  ## Pull updates from remote
	@git pull --rebase

help:  ## Show this help menu
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: link-tmux link-vim link-nvim link-prezto link-etc link-git link-bash link-zsh link-launchd link-cheat link-gpg link-powershell check-dead clean-dead submodules iterm-integration update help
