#!/usr/bin/env bash

# @file install/linux/client/docker.sh
# @brief Install Docker Engine on Linux client machines.
# @description
#   Removes legacy Docker packages, configures Docker's apt repository, and
#   installs the current Docker Engine packages.

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
    docker-ce
    docker-ce-cli
    containerd.io
    docker-compose-plugin
)

#
# @description Remove legacy Docker packages that conflict with Docker Engine.
#
function uninstall_old_docker() {
    local packages=(
        "docker"
        "docker-engine"
        "docker.io"
        "containerd"
        "runc"
    )
    for package in "${packages[@]}"; do
        if dpkg -s "${package}" >/dev/null 2>&1; then
            uninstall_apt_packages "${package}"
        fi
    done
}

#
# @description Configure Docker's official apt repository and signing key.
#
function setup_repository() {

    # Update the apt package index and install packages to allow apt to use a repository over HTTPS:
    run_apt_get update
    install_apt_packages \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    # Add Docker’s official GPG key:
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    # Use the following command to set up the repository:
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
}

#
# @description Install Docker Engine and the configured companion packages.
#
function install_docker_engine() {
    # Update the apt package index:
    run_apt_get update

    # Install Docker Engine, containerd, and Docker Compose.
    install_apt_packages "${PACKAGES[@]}"

}

#
# @description Remove the configured Docker Engine packages.
#
function uninstall_docker_engine() {
    uninstall_apt_packages "${PACKAGES[@]}"
}

#
# @description Install Docker Engine from Docker's official Linux repository.
#
function main() {
    uninstall_old_docker
    setup_repository
    install_docker_engine
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
