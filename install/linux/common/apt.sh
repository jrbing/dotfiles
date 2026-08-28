#!/usr/bin/env bash

# @file install/linux/common/apt.sh
# @brief Shared apt package-operation adapter for Linux.
# @description
#   Bootstraps `sudo` when running in a minimal container and preserves proxy
#   environment variables for privileged apt operations.

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

#
# @description Run `apt-get` with the required privilege and proxy handling.
#
function run_apt_get() {
    if ! command -v sudo >/dev/null 2>&1; then
        apt-get update
        apt-get install -y sudo
    fi

    sudo --preserve-env=http_proxy,https_proxy,no_proxy apt-get "$@"
}

#
# @description Install the supplied apt packages.
# @arg $@ string Package names.
#
function install_apt_packages() {
    run_apt_get install -y "$@"
}

#
# @description Remove the supplied apt packages.
# @arg $@ string Package names.
#
function uninstall_apt_packages() {
    run_apt_get remove -y "$@"
}
