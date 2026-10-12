#!/usr/bin/env bash

# @file install/macos/common/misc.sh
# @brief Install optional macOS utilities and GUI applications.
# @description
#   Installs non-essential brew packages, casks, and user-specific extras for
#   daily development use.

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
	set -x
fi

if ! declare -F install_brew_packages &>/dev/null; then
	source "$(dirname "${BASH_SOURCE[0]}")/brew_packages.sh"
fi

readonly BREW_PACKAGES=(
	aria2
	astyle
	atuin
	clipper
	cmake
	colima
	direnv
	docker
	docker-buildx
	eza
	ffmpeg
	git-delta
	git-filter-repo
	gnupg
	go-task
	helm
	htop
	icdiff
	imagemagick
	just
	krew
	kubectx
	mole
	nmap
	pinentry-mac
	reattach-to-user-namespace
	ripgrep
	stern
	terminal-notifier
	tmux
	watchexec
	wget
	yt-dlp
	zoxide
)

readonly CASK_PACKAGES=(
	1password
	1password-cli
	alfred
	font-inconsolata-dz-for-powerline
	font-inconsolata-go-nerd-font
	font-inconsolata-nerd-font
	iina
	iterm2
	lens
	macvim-app
	serial
	syncthing-app
	vimr
	vlc
)

#
# @description Install the configured optional macOS packages and casks.
#
function main() {
	install_brew_packages formula "${BREW_PACKAGES[@]}"
	install_brew_packages cask "${CASK_PACKAGES[@]}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	main
fi
