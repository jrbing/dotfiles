#!/usr/bin/env bash

# @file install/linux/common/tmux.sh
# @brief Install tmux on Linux.
# @description
#   Installs or removes the Linux `tmux` package while preserving proxy
#   environment variables.

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly PACKAGES=(
    tmux
)

#
# @description Install the Linux `tmux` package.
#
function install_tmux() {
    sudo --preserve-env=http_proxy,https_proxy,no_proxy apt-get install -y "${PACKAGES[@]}"
}

#
# @description Remove the Linux `tmux` package.
#
function uninstall_tmux() {
    sudo apt-get remove -y "${PACKAGES[@]}"
}

#
# @description Run the Linux tmux installation flow.
#
function main() {
    install_tmux
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
