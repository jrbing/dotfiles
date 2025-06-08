#===============================================================================
# vim: softtabstop=4 shiftwidth=4 noexpandtab fenc=utf-8 spelllang=en nolist
#===============================================================================

dotfiles=~/.dotfiles

BASH_FILES := $(shell cd $(dotfiles)/bash; ls)
GPG_FILES := $(shell cd $(dotfiles)/gnupg; ls)
GIT_FILES := $(shell cd $(dotfiles)/git; ls)
ETC_FILES := $(shell cd $(dotfiles)/etc; ls)
ZSH_FILES := zlogin zlogout zpreztorc zprofile zshenv zshrc zimrc

all: help

link: link-tmux link-vim link-etc link-xdg link-git link-bash link-zsh link-gpg  ## Link all dotfiles to their respective locations

link-tmux:
	@cd ~ && ln -nfs $(dotfiles)/tmux/oh-my-tmux/.tmux.conf .tmux.conf; \
				ln -nfs $(dotfiles)/tmux/tmux.conf.local .tmux.conf.local; \

link-vim:
	@cd ~ && ln -nfs $(dotfiles)/vim/ .vim; \
				ln -nfs $(dotfiles)/vim/vimrc .vimrc; \
				ln -nfs $(dotfiles)/vim/gvimrc .gvimrc

link-nvim:
	@cd ~ && ln -nfs $(dotfiles)/nvim/ .config/nvim

link-etc:
	@cd ~ && for file in $(ETC_FILES); do ln -nfs .dotfiles/etc/$$file .$$file; done

link-xdg:
	@cd ~ && mkdir -p ~/.config/aria2;
	@cd ~ && mkdir -p ~/.config/cheat;
	@cd ~ && mkdir -p ~/.config/powershell;
	@cd ~ && mkdir -p ~/.config/mise;
	@cd ~ && ln -nfs $(dotfiles)/xdg/topgrade.toml ~/.config/topgrade.toml;
	@cd ~ && ln -nfs $(dotfiles)/xdg/starship.toml ~/.config/starship.toml;
	@cd ~ && ln -nfs $(dotfiles)/xdg/aria2.conf ~/.config/aria2/aria2.conf;
	@cd ~ && ln -nfs $(dotfiles)/xdg/mise.toml ~/.config/mise/config.toml;
	@cd ~ && ln -nfs $(dotfiles)/cheat/conf.yml ~/.config/cheat/conf.yml;
	@cd ~ && ln -nfs $(dotfiles)/powershell/profile_macos.ps1 ~/.config/powershell/profile.ps1;

link-git:
	@cd ~ && for file in $(GIT_FILES); do ln -nfs .dotfiles/git/$$file .$$file; done

link-bash:
	@cd ~ && for file in $(BASH_FILES); do ln -nfs .dotfiles/bash/$$file .$$file; done

link-zsh:
	@cd ~ && for file in $(ZSH_FILES); do ln -nfs .dotfiles/zsh/$$file .$$file; done

link-gpg:
	@cd ~ && for file in $(GPG_FILES); do ln -nfs "$$HOME/.dotfiles/gnupg/$$file" "$$HOME/.gnupg/$$file"; done

link-vscode:
	@cd ~ && ln -nfs $(dotfiles)/vscode/macos-settings.json ~/Library/Application\ Support/Code/User/settings.json
	@cd ~ && ln -nfs $(dotfiles)/vscode/macos-keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

link-pandoc:
	@cd ~ && ln -nfs $(dotfiles)/pandoc/ .pandoc

link-taskfile:
	@cd ~ && ln -nfs $(dotfiles)/Taskfile.yaml Taskfile.yaml

check-dead:  ## Check for dead symlinks
	@find ~ -maxdepth 1 -name '.*' -type l -exec test ! -e {} \; -print

clean-dead:  ## Cleanup dead symlinks
	@find ~ -maxdepth 1 -name '.*' -type l -exec test ! -e {} \; -delete

clean:  ## Remove all temporary and backup files
	@git clean -dfx

submodules:  ## Update all submodule references
	@git submodule update --rebase --remote --recursive

pandoc-document-template:	## Update source pandoc document template
	@curl -s https://api.github.com/repos/Wandmalfarbe/pandoc-latex-template/releases/latest \
			| grep "browser_download_url.*Eisvogel.zip" \
			| cut -d : -f 2,3 \
			| tr -d \" \
			| wget -qi - \
			&& unzip -qq Eisvogel.zip -d $(dotfiles)/pandoc/templates \
			&& mv $(dotfiles)/pandoc/templates/Eisvogel*/eisvogel.beamer $(dotfiles)/pandoc/templates/ \
			&& mv $(dotfiles)/pandoc/templates/Eisvogel*/eisvogel.latex $(dotfiles)/pandoc/templates/ \
			&& rm -rf $(dotfiles)/pandoc/templates/Eisvogel* \
			&& rm Eisvogel.zip

#\ > $(dotfiles)/pandoc/templates/eisvogel.latex

install-pandoc-template-dependencies:	## Install pandoc document template dependencies
	@tlmgr install soul adjustbox babel-german background bidi collectbox csquotes everypage filehook footmisc footnotebackref framed fvextra letltxmacro ly1 mdframed mweights needspace pagecolor sourcecodepro sourcesanspro titling ucharcat unicode-math upquote xecjk xurl zref draftwatermark

update:  ## Pull updates from remote
	@git pull --rebase

help:  ## Show this help menu
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: link-tmux link-vim link-nvim link-etc link-xdg link-git link-bash link-zsh link-gpg check-dead clean-dead submodules update help

