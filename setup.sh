#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

# shellcheck disable=SC2016
declare -r DOTFILES_LOGO='
                          /$$                                      /$$
                         | $$                                     | $$
     /$$$$$$$  /$$$$$$  /$$$$$$   /$$   /$$  /$$$$$$      /$$$$$$$| $$$$$$$
    /$$_____/ /$$__  $$|_  $$_/  | $$  | $$ /$$__  $$    /$$_____/| $$__  $$
   |  $$$$$$ | $$$$$$$$  | $$    | $$  | $$| $$  \ $$   |  $$$$$$ | $$  \ $$
    \____  $$| $$_____/  | $$ /$$| $$  | $$| $$  | $$    \____  $$| $$  | $$
    /$$$$$$$/|  $$$$$$$  |  $$$$/|  $$$$$$/| $$$$$$$//$$ /$$$$$$$/| $$  | $$
   |_______/  \_______/   \___/   \______/ | $$____/|__/|_______/ |__/  |__/
                                           | $$
                                           | $$
                                           |__/

                 *** This is setup script for my dotfiles ***
                     https://github.com/jrbing/dotfiles
'

# declare -r DOTFILES_REPO_URL="git@github.com:jrbing/dotfiles.git"
declare -r DOTFILES_REPO_URL="https://github.com/jrbing/dotfiles"
declare -r BRANCH_NAME="${BRANCH_NAME:-main}"
declare -r DOTFILES_REVISION="${DOTFILES_REVISION:-}"
declare -r HOMEBREW_INSTALL_REVISION="d797f6b3d244abc548808fd75b879ca6860c653f"
declare -r CHEZMOI_VERSION="v2.72.2"
declare -r CHEZMOI_INSTALLER_SHA256="75de125a45a82b53c16546db7057052e98c11866ded27c4b6f95a51f59432e7b"

function is_ci() {
    "${CI:-false}"
}

function is_tty() {
    [ -t 0 ]
}

function is_not_tty() {
    ! is_tty
}

function is_ci_or_not_tty() {
    is_ci || is_not_tty
}

function at_exit() {
    AT_EXIT+="${AT_EXIT:+$'\n'}"
    AT_EXIT+="${*?}"
    # shellcheck disable=SC2064
    trap "${AT_EXIT}" EXIT
}

function get_platform() {
    local os_type arch_type
    os_type="$(uname -s)"
    arch_type="$(uname -m)"

    case "${os_type}" in
    Darwin) os_type="darwin" ;;
    Linux) os_type="linux" ;;
    *)
        echo "Invalid OS type: ${os_type}" >&2
        return 1
        ;;
    esac

    case "${arch_type}" in
    arm64 | aarch64) arch_type="arm64" ;;
    amd64 | x86_64) arch_type="x86_64" ;;
    esac

    printf '%s %s\n' "${os_type}" "${arch_type}"
}

function keepalive_sudo_linux() {
    # Might as well ask for password up-front, right?
    echo "Checking for \`sudo\` access which may request your password."
    # sudo
    sudo pwd

    # Keep-alive: update existing sudo time stamp if set, otherwise do nothing.
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done 2>/dev/null &
}

function keepalive_sudo_macos() {
    # ref. https://github.com/reitermarkus/dotfiles/blob/master/.sh#L85-L116
    (
        builtin read -r -s -p "Password: " </dev/tty
        builtin echo "add-generic-password -U -s 'dotfiles' -a '${USER}' -w '${REPLY}'"
    ) | /usr/bin/security -i
    printf "\n"
    at_exit "
                echo -e '\033[0;31mRemoving password from Keychain …\033[0m'
                /usr/bin/security delete-generic-password -s 'dotfiles' -a '${USER}'
            "
    SUDO_ASKPASS="$(/usr/bin/mktemp)"
    at_exit "
                echo -e '\033[0;31mDeleting SUDO_ASKPASS script …\033[0m'
                /bin/rm -f '${SUDO_ASKPASS}'
            "
    {
        echo "#!/bin/sh"
        echo "/usr/bin/security find-generic-password -s 'dotfiles' -a '${USER}' -w"
    } >"${SUDO_ASKPASS}"

    /bin/chmod +x "${SUDO_ASKPASS}"
    export SUDO_ASKPASS

    if ! /usr/bin/sudo -A -kv 2>/dev/null; then
        echo -e '\033[0;31mIncorrect password.\033[0m' 1>&2
        exit 1
    fi
}

function keepalive_sudo() {
    if [ "${DOTFILES_OS:-}" == "darwin" ]; then
        keepalive_sudo_macos
    elif [ "${DOTFILES_OS:-}" == "linux" ]; then
        keepalive_sudo_linux
    else
        echo "Invalid OS type: ${DOTFILES_OS:-}" >&2
        exit 1
    fi
}

function get_homebrew_bin() {
    case "${DOTFILES_ARCH:-}" in
    arm64) printf '%s\n' "/opt/homebrew/bin/brew" ;;
    x86_64) printf '%s\n' "/usr/local/bin/brew" ;;
    *)
        echo "Invalid CPU arch: ${DOTFILES_ARCH:-}" >&2
        return 1
        ;;
    esac
}

function initialize_os_macos() {
    function is_homebrew_exists() {
        command -v brew &>/dev/null
    }

    # Instal Homebrew if needed.
    if ! is_homebrew_exists; then
        /bin/bash -c "$(curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/${HOMEBREW_INSTALL_REVISION}/install.sh")"
    fi

    # Setup Homebrew envvars.
    local brew_bin
    brew_bin="$(get_homebrew_bin)"
    eval "$("${brew_bin}" shellenv)"
}

function initialize_os_linux() {
    :
}

function initialize_os_env() {
    local platform os_type arch_type
    if ! platform="$(get_platform)"; then
        exit 1
    fi
    read -r os_type arch_type <<<"${platform}"
    export DOTFILES_OS="${os_type}" DOTFILES_ARCH="${arch_type}"

    if [ "${DOTFILES_OS}" == "darwin" ]; then
        initialize_os_macos
    elif [ "${DOTFILES_OS}" == "linux" ]; then
        initialize_os_linux
    else
        echo "Invalid OS type: ${DOTFILES_OS}" >&2
        exit 1
    fi
}

function sha256_file() {
    if command -v sha256sum >/dev/null; then
        sha256sum "$1" | cut -d ' ' -f 1
    else
        shasum -a 256 "$1" | cut -d ' ' -f 1
    fi
}

function run_chezmoi() {
    local bin_dir="${HOME}/.local/bin"
    local installer
    local -a init_options=(--force --use-builtin-git true)
    local -a source_options=(--branch "${BRANCH_NAME}")
    local -a apply_options=()
    export PATH="${PATH}:${bin_dir}"

    installer="$(mktemp)"
    if ! curl -fsLS --output "${installer}" https://get.chezmoi.io; then
        rm -f "${installer}"
        return 1
    fi
    if [ "$(sha256_file "${installer}")" != "${CHEZMOI_INSTALLER_SHA256}" ]; then
        echo "Chezmoi installer checksum mismatch" >&2
        rm -f "${installer}"
        return 1
    fi
    if ! sh "${installer}" -- -b "${bin_dir}" -t "${CHEZMOI_VERSION}"; then
        rm -f "${installer}"
        return 1
    fi
    rm -f "${installer}"
    local chezmoi_cmd="${bin_dir}/chezmoi"

    if is_ci_or_not_tty; then
        # Supply template data because --no-tty makes promptString unavailable.
        init_options+=(--no-tty --promptString "email=${DOTFILES_EMAIL:-}" --promptString "system=${DOTFILES_SYSTEM:-client}")
        apply_options+=(--no-tty)
    fi

    if [ -n "${DOTFILES_REVISION:-}" ]; then
        source_options=(--revision "${DOTFILES_REVISION}")
    fi

    # run `chezmoi init` to setup the source directory,
    # generate the config file, and optionally update the destination directory
    # to match the target state.
    "${chezmoi_cmd}" init "${DOTFILES_REPO_URL}" \
        "${init_options[@]}" \
        "${source_options[@]}"

    # Add to PATH for installing the necessary binary files under `$HOME/.local/bin`.
    export PATH="${PATH}:${HOME}/.local/bin"

    # run `chezmoi apply` to ensure that targets... are in the target state,
    # updating them if necessary.
    "${chezmoi_cmd}" apply "${apply_options[@]}"

    # purge the binary of the chezmoi cmd
    rm -fv "${chezmoi_cmd}"
}

function initialize_dotfiles() {

    if ! is_ci_or_not_tty; then
        # - /dev/tty of the github workflow is not available.
        # - We can use password-less sudo in the github workflow.
        # Therefore, skip the sudo keep alive function.
        keepalive_sudo
    fi
    run_chezmoi
}

function main() {
    echo "${DOTFILES_LOGO}"

    initialize_os_env
    initialize_dotfiles
}

if [[ "${BASH_SOURCE[0]:-}" == "$0" || -z "${BASH_SOURCE[0]:-}" ]]; then
    main
fi
