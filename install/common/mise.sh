#!/usr/bin/env bash

# @file install/common/mise.sh
# @brief Install tools managed by `mise`.
# @description
#   Assumes the OS package manager installed `mise`, then installs the tools
#   declared in the managed Mise configuration.

# set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly DEFAULT_NPM_MIN_RELEASE_AGE_DAYS=7

#
# @description Run `mise install` with the repository npm age gate.
#
function run_mise_install() {
    # `MISE_CURRENT_VERSION` is interpreted by mise as a tool env override for `current`.
    unset MISE_CURRENT_VERSION
    mise install --before "${DEFAULT_NPM_MIN_RELEASE_AGE_DAYS}d"
}

#
# @description Install the configured Mise tools.
#
function main() {
    run_mise_install
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
