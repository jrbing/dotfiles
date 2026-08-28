#!/usr/bin/env bats

# shellcheck disable=SC2030,SC2031
# shellcheck source=../../../../install/macos/common/brew_packages.sh
readonly ROOT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../.." && pwd)"
readonly SCRIPT_PATH="${ROOT_DIR}/install/macos/common/brew_packages.sh"

setup() {
    TEST_DIR="$(mktemp -d)"
    mkdir -p "${TEST_DIR}/bin"
    unset CI BREW_FORMULAS BREW_CASKS

    cat >"${TEST_DIR}/bin/brew" <<'EOF'
#!/usr/bin/env bash

printf '%s\n' "$*" >>"${BREW_LOG}"

if [[ "$1" != "list" ]]; then
    exit 0
fi

mode=formula
shift
if [[ "${1:-}" == "--cask" ]]; then
    mode=cask
    shift
elif [[ "${1:-}" == "--formula" ]]; then
    shift
fi

package="${1:?}"
case "${mode}:${package}" in
    formula:*) [[ " ${BREW_FORMULAS:-} " == *" ${package} "* ]] ;;
    cask:*) [[ " ${BREW_CASKS:-} " == *" ${package} "* ]] ;;
esac
EOF
    chmod +x "${TEST_DIR}/bin/brew"

    BREW_LOG="${TEST_DIR}/brew.log"
    export BREW_LOG
    PATH="${TEST_DIR}/bin:${PATH}"
    export PATH

    source "${SCRIPT_PATH}"
}

teardown() {
    rm -rf "${TEST_DIR}"
}

@test "installs missing formulas with force" {
    run install_brew_packages formula cmake git

    [ "${status}" -eq 0 ]
    [ "$(cat "${BREW_LOG}")" = $'list --formula cmake\nlist --formula git\ninstall --force cmake git' ]
}

@test "installs missing casks with cask mode and force" {
    run install_brew_packages cask iina vlc

    [ "${status}" -eq 0 ]
    [ "$(cat "${BREW_LOG}")" = $'list --cask iina\nlist --cask vlc\ninstall --cask --force iina vlc' ]
}

@test "skips already-installed formulas and casks" {
    export BREW_FORMULAS="cmake"
    export BREW_CASKS="iina"

    run install_brew_packages formula cmake
    [ "${status}" -eq 0 ]
    run install_brew_packages cask iina

    [ "${status}" -eq 0 ]
    [ "$(cat "${BREW_LOG}")" = $'list --formula cmake\nlist --cask iina' ]
}

@test "uses brew info for missing packages in CI" {
    export CI=true

    run install_brew_packages cask iina

    [ "${status}" -eq 0 ]
    [ "$(cat "${BREW_LOG}")" = $'list --cask iina\ninfo --cask iina' ]
}

@test "preserves tmux's non-forced CI install path" {
    export CI=true
    source "${ROOT_DIR}/install/macos/common/tmux.sh"

    run install_tmux

    [ "${status}" -eq 0 ]
    [ "$(cat "${BREW_LOG}")" = $'list --formula tmux\ninstall tmux' ]
}
