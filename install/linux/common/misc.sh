#!/usr/bin/env bash

# @file install/linux/client/misc.sh
# @brief Install optional Linux client applications.
# @description
#   Installs or removes a small set of GUI applications used on Linux client
#   machines.

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
    guake
    gparted
)

#
# @description Install the optional Linux client packages.
#
function install_misc() {
    install_apt_packages "${PACKAGES[@]}"
}

#
# @description Remove the optional Linux client packages.
#
function uninstall_misc() {
    uninstall_apt_packages "${PACKAGES[@]}"
}

#
# @description Run the optional Linux client package installation flow.
#
function main() {
    install_misc
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
