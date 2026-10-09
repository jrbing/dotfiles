#!/usr/bin/env bash

# Omarchy owns desktop packages and system updates. Install only prerequisites
# for the repository's shell, editor, and Mise-managed development tools.
set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

function install_omarchy_dependencies() {
    local -a packages=(curl git zsh vim tmux openssh unzip base-devel)

    # Omarchy can provide Mise as mise-bin. Do not replace a working install.
    if ! command -v mise >/dev/null 2>&1; then
        packages+=(mise)
    fi

    omarchy pkg add "${packages[@]}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_omarchy_dependencies
fi
