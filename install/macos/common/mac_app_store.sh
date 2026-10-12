#!/usr/bin/env bash

# @file install/macos/common/mac_app_store.sh
# @brief Install selected Mac App Store applications.
# @description
#   Ensures the `mas` CLI exists and installs the configured Mac App Store apps
#   when the script is not running in CI.

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

#
# @description Check whether the `mas` CLI is available.
#
function is_mas_installed() {
    command -v mas &> /dev/null
}

#
# @description Install the `mas` CLI through Homebrew when needed.
#
function install_mas() {
    if ! is_mas_installed; then
        brew install mas
    fi
}

#
# @description Install the configured Mac App Store applications.
#
function main() {
    install_mas
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
