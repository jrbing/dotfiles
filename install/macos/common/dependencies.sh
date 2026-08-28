#!/usr/bin/env bash

# @file install/macos/common/dependencies.sh
# @brief Install essential Homebrew packages for macOS.
# @description
#   Installs the core command-line packages required by the dotfiles.
#   Optional utilities and GUI applications live in
#   `install/macos/common/misc.sh`.

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
	set -x
fi

if ! declare -F install_brew_packages &>/dev/null; then
	source "$(dirname "${BASH_SOURCE[0]}")/brew_packages.sh"
fi

readonly BREW_PACKAGES=(
	cmake
	git
	gpg
	pinentry-mac
	vim
	zsh
)

#
# @description Install the required Homebrew dependencies.
#
function main() {
	install_brew_packages formula "${BREW_PACKAGES[@]}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	main
fi
