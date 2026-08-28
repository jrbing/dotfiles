#!/usr/bin/env bats
# shellcheck disable=SC2030,SC2031,SC2329

load_setup() {
    # shellcheck disable=SC1090
    source "${BATS_TEST_DIRNAME}/../setup.sh"
}

@test "normalizes Intel macOS to x86_64" {
    load_setup
    uname() {
        case "$1" in
            -s) printf 'Darwin\n' ;;
            -m) printf 'x86_64\n' ;;
        esac
    }

    run get_platform

    [ "$status" -eq 0 ]
    [ "$output" = "darwin x86_64" ]
}

@test "retains arm64 for Apple Silicon macOS" {
    load_setup
    uname() {
        case "$1" in
            -s) printf 'Darwin\n' ;;
            -m) printf 'arm64\n' ;;
        esac
    }

    run get_platform

    [ "$status" -eq 0 ]
    [ "$output" = "darwin arm64" ]
}

@test "normalizes x86_64 Linux" {
    load_setup
    uname() {
        case "$1" in
            -s) printf 'Linux\n' ;;
            -m) printf 'x86_64\n' ;;
        esac
    }

    run get_platform

    [ "$status" -eq 0 ]
    [ "$output" = "linux x86_64" ]
}

@test "normalizes aarch64 Linux to arm64" {
    load_setup
    uname() {
        case "$1" in
            -s) printf 'Linux\n' ;;
            -m) printf 'aarch64\n' ;;
        esac
    }

    run get_platform

    [ "$status" -eq 0 ]
    [ "$output" = "linux arm64" ]
}

@test "selects the Intel Homebrew path for x86_64" {
    load_setup
    DOTFILES_ARCH=x86_64

    run get_homebrew_bin

    [ "$status" -eq 0 ]
    [ "$output" = "/usr/local/bin/brew" ]
}

@test "selects the ARM Homebrew path for arm64" {
    load_setup
    DOTFILES_ARCH=arm64

    run get_homebrew_bin

    [ "$status" -eq 0 ]
    [ "$output" = "/opt/homebrew/bin/brew" ]
}

@test "setup exports the normalized platform for Darwin dispatch" {
    load_setup
    uname() {
        case "$1" in
            -s) printf 'Darwin\n' ;;
            -m) printf 'x86_64\n' ;;
        esac
    }
    initialize_os_macos() { dispatched="macos"; }
    initialize_os_linux() { dispatched="linux"; }

    initialize_os_env

    [ "$dispatched" = "macos" ]
    [ "$DOTFILES_OS" = "darwin" ]
    [ "$DOTFILES_ARCH" = "x86_64" ]
}

@test "Chezmoi config persists the normalized setup platform" {
    load_setup
    uname() {
        case "$1" in
            -s) printf 'Darwin\n' ;;
            -m) printf 'x86_64\n' ;;
        esac
    }
    initialize_os_macos() { :; }
    initialize_os_linux() { :; }
    initialize_os_env

    run chezmoi execute-template --init \
        --promptString email=test@example.com \
        --promptString system=client \
        --file "${BATS_TEST_DIRNAME}/../home/.chezmoi.yaml.tmpl"

    [ "$status" -eq 0 ]
    [[ "$output" == *'os: "darwin"'* ]]
    [[ "$output" == *'arch: "x86_64"'* ]]
}

@test "stdin bootstrap reaches main without BASH_SOURCE" {
    run env PATH=/nonexistent /bin/bash -u <"${BATS_TEST_DIRNAME}/../setup.sh"

    [ "$status" -eq 1 ]
    [[ "$output" == *"Invalid OS type:"* ]]
}
