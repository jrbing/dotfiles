#!/usr/bin/env bash

# @file install/linux/common/ssh.sh
# @brief Install the OpenSSH client on Linux.
# @description
#   Installs or removes the Linux OpenSSH client package while preserving
#   proxy-related environment variables.

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

if ! declare -F install_apt_packages >/dev/null 2>&1; then
    # shellcheck source=apt.sh
    source "${BASH_SOURCE[0]%/*}/apt.sh"
fi

readonly PACKAGES=(
    openssh-client
)

#
# @description Install the OpenSSH client package.
#
function install_openssh() {
    install_apt_packages "${PACKAGES[@]}"
}

#
# @description Remove the OpenSSH client package.
#
function uninstall_openssh() {
    uninstall_apt_packages "${PACKAGES[@]}"
}

#
# @description Run the OpenSSH client installation flow.
#
function main() {
    install_openssh
}

if [ ${#BASH_SOURCE[@]} = 1 ]; then
    main
fi
