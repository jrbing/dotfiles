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
    if [[ "${BASH_SOURCE[0]}" == */* ]]; then
        source "${BASH_SOURCE[0]%/*}/apt.sh"
    else
        source "./apt.sh"
    fi
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
# @description Configure the official Mise apt repository when required.
#
function configure_mise_repository() {
    install_apt_packages ca-certificates
    sudo install -dm 755 /etc/apt/keyrings
    curl -fSso /tmp/mise-archive-keyring.asc https://mise.jdx.dev/gpg-key.pub
    sudo install -m 644 /tmp/mise-archive-keyring.asc /etc/apt/keyrings/mise-archive-keyring.asc
    rm /tmp/mise-archive-keyring.asc
    printf 'deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.asc arch=%s] https://mise.jdx.dev/deb stable main\n' "$(dpkg --print-architecture)" |
        sudo tee /etc/apt/sources.list.d/mise.list >/dev/null
    run_apt_get update
}

#
# @description Install Mise from its official apt repository.
#
function install_mise() {
    if command -v mise >/dev/null 2>&1; then
        return 0
    fi

    configure_mise_repository
    install_apt_packages mise
}

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
        install_mise
        return
    fi

    install_apt_packages "${missing_packages[@]}"
    install_mise
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
