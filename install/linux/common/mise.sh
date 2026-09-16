#!/usr/bin/env bash

# @file install/linux/common/mise.sh
# @brief Install Mise from its official apt repository.

set -Eeuo pipefail

if ! declare -F install_apt_packages >/dev/null 2>&1; then
    # shellcheck source=apt.sh
    source "${BASH_SOURCE[0]%/*}/apt.sh"
fi

#
# @description Report old local binaries without modifying unverified user files.
#
function warn_legacy_local_binaries() {
    local binary

    for binary in mise starship; do
        if [[ -e "${HOME}/.local/bin/${binary}" || -L "${HOME}/.local/bin/${binary}" ]]; then
            printf 'Legacy local %s found at %s; left unchanged. Move it out of PATH after verifying ownership.\n' \
                "${binary}" "${HOME}/.local/bin/${binary}" >&2
        fi
    done
}

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
# @description Install Mise from apt, preserving any existing local binaries.
#
function install_mise() {
    local legacy_mise="${HOME}/.local/bin/mise"

    warn_legacy_local_binaries

    if [[ ! -e "${legacy_mise}" && ! -L "${legacy_mise}" ]] && command -v mise >/dev/null 2>&1; then
        return
    fi

    configure_mise_repository
    install_apt_packages mise
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_mise
fi
