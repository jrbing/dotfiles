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

if ! declare -F install_apt_packages >/dev/null 2>&1; then
    # shellcheck source=apt.sh
    source "${BASH_SOURCE[0]%/*}/apt.sh"
fi

readonly PACKAGES=(
    tmux
)

#
# @description Install the Linux `tmux` package.
#
function install_tmux() {
    install_apt_packages "${PACKAGES[@]}"
}

#
# @description Remove the Linux `tmux` package.
#
function uninstall_tmux() {
    uninstall_apt_packages "${PACKAGES[@]}"
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
