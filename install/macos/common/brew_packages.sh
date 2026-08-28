#!/usr/bin/env bash

# @file install/macos/common/brew_packages.sh
# @brief Shared Homebrew package installation helpers for macOS.

function is_brew_package_installed() {
	local package="$1"
	local package_type="${2:-formula}"

	if [[ "${package_type}" == "cask" ]]; then
		brew list --cask "${package}" &>/dev/null
	else
		brew list --formula "${package}" &>/dev/null
	fi
}

#
# @description Install missing Homebrew packages or casks.
# @arg $1 string Optional formula/cask mode.
# @arg remaining string Homebrew package names.
#
# The internal flags keep the tmux GitHub Actions workaround explicit while
# leaving the package and cask callers on the normal forced-install path.
#
function install_brew_packages() {
	local package_type="formula"
	local force=true
	local install_in_ci=false

	while [[ $# -gt 0 ]]; do
		case "$1" in
		formula | --formula)
			package_type="formula"
			shift
			;;
		cask | --cask)
			package_type="cask"
			shift
			;;
		--force)
			force=true
			shift
			;;
		--no-force)
			force=false
			shift
			;;
		--install-in-ci)
			install_in_ci=true
			shift
			;;
		--)
			shift
			break
			;;
		-*)
			printf 'Unknown Homebrew installer option: %s\n' "$1" >&2
			return 2
			;;
		*)
			break
			;;
		esac
	done

	local missing_packages=()
	local package

	for package in "$@"; do
		if ! is_brew_package_installed "${package}" "${package_type}"; then
			missing_packages+=("${package}")
		fi
	done

	if [[ ${#missing_packages[@]} -eq 0 ]]; then
		return 0
	fi

	local brew_options=()
	if [[ "${package_type}" == "cask" ]]; then
		brew_options+=(--cask)
	fi

	if "${CI:-false}" && ! "${install_in_ci}"; then
		brew info "${brew_options[@]}" "${missing_packages[@]}"
	elif "${force}"; then
		brew install "${brew_options[@]}" --force "${missing_packages[@]}"
	else
		brew install "${brew_options[@]}" "${missing_packages[@]}"
	fi
}
