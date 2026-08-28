#!/usr/bin/env bash

# @file install/linux/common/dependencies.sh
# @brief Install essential Linux packages for the dotfiles.
# @description
#   Ensures the base command-line toolchain required by the repository is
#   present, including `sudo` when starting from a minimal container.

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

if ! declare -F install_apt_packages >/dev/null 2>&1; then
    # shellcheck source=apt.sh
    source "${BASH_SOURCE[0]%/*}/apt.sh"
fi

readonly PACKAGES=(
    busybox
    cmake
    curl
    git
    gpg
    htop
    iproute2
    iputils-ping
    sudo
    unzip
    vim
    wget
    zsh
)

#
# @description Install every missing Linux dependency package.
#
function install_linux_dependencies() {
    local missing_packages=()
    local package

    for package in "${PACKAGES[@]}"; do
        if ! command -v "${package}" >/dev/null 2>&1; then
            missing_packages+=("${package}")
        fi
    done

    if [ "${#missing_packages[@]}" -eq 0 ]; then
        return 0
    fi

    install_apt_packages "${missing_packages[@]}"
}

#
# @description Install the required Linux dependencies.
#
function main() {
    install_linux_dependencies
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
