#!/usr/bin/env bash

# @file install/common/mise.sh
# @brief Install tools managed by `mise`.
# @description
#   Assumes the OS package manager installed `mise`, then installs the tools
#   declared in the managed Mise configuration.
#
#   The minimum release age is configured in the managed Mise config
#   (`settings.minimum_release_age`), which exempts the Codex and Claude CLIs
#   via `settings.minimum_release_age_excludes`. Passing `--before` here would
#   override those per-tool exemptions, so the cutoff stays in the config.

# set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

#
# @description Install the configured Mise tools.
#
function main() {
    # `MISE_CURRENT_VERSION` is interpreted by mise as a tool env override for `current`.
    unset MISE_CURRENT_VERSION
    mise install
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
