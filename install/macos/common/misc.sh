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
	atuin
	clipper
	cmake
	colima
	direnv
	docker
	docker-buildx
	eza
	ffmpeg
	gh
	git-delta
	git-filter-repo
	gnupg
	go
	go-task
	helm
	htop
	icdiff
	imagemagick
	just
	krew
	kubectx
	kubernetes-cli
	mise
	mole
	nmap
	node
	opencode
	pinentry-mac
	reattach-to-user-namespace
	ripgrep
	starship
	stern
	terminal-notifier
	tmux
	topgrade
	watchexec
	wget
	yt-dlp
	zoxide
)

# readonly BREW_TAPS=(
# #manaflow-ai/cmux
# )

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
# @description Check whether a brew tap is already configured.
# @arg $1 string Tap name.
#
function is_brew_tap_installed() {
	local tap="$1"

	brew tap | grep --fixed-strings --line-regexp --quiet "${tap}"
}

#
# @description Install every missing tap from `BREW_TAPS` unless running in CI.
#
function install_brew_taps() {
	if "${CI:-false}"; then
		return 0
	fi

	local missing_taps=()
	local tap

	for tap in "${BREW_TAPS[@]}"; do
		if ! is_brew_tap_installed "${tap}"; then
			missing_taps+=("${tap}")
		fi
	done

	if [[ ${#missing_taps[@]} -gt 0 ]]; then
		for tap in "${missing_taps[@]}"; do
			brew tap "${tap}"
		done
	fi
}

#
# @description Install the configured optional macOS packages and casks.
#
function main() {
	# install_brew_taps
	install_brew_packages formula "${BREW_PACKAGES[@]}"
	install_brew_packages cask "${CASK_PACKAGES[@]}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	main
fi
