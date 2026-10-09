#!/usr/bin/env bats

setup() {
    export DOTFILES_OS=linux DOTFILES_DISTRO=omarchy DOTFILES_DISTRO_LIKE=arch
    export CALL_LOG="${BATS_TEST_TMPDIR}/calls"
    export TEST_BIN="${BATS_TEST_TMPDIR}/bin"
    export INSTALLED_PACKAGES="${BATS_TEST_TMPDIR}/packages"
    mkdir -p "${TEST_BIN}" "${INSTALLED_PACKAGES}"
    : >"${CALL_LOG}"
    ROOT_DIR="${BATS_TEST_DIRNAME}/.."
}

render() {
    chezmoi execute-template --init --source "${ROOT_DIR}/home" \
        --promptString email=test@example.com --promptString system=client \
        --file "${ROOT_DIR}/$1"
}

@test "Omarchy renders every Linux script without apt or Docker setup" {
    local template
    for template in "${ROOT_DIR}"/home/.chezmoiscripts/linux/*.tmpl; do
        run render "${template#"${ROOT_DIR}/"}"
        [ "$status" -eq 0 ]
        [[ "$output" != *apt-get* ]]
        [[ "$output" != *download.docker.com* ]]
    done
    run render home/.chezmoiscripts/linux/run_once_before_50-common-dependencies.sh.tmpl
    [[ "$output" == *'omarchy pkg add'* ]]
}

@test "Debian family detection accepts distribution IDs and ID_LIKE tokens" {
    local distro system
    for system in client server; do
        for distro in ubuntu debian derivative; do
            export DOTFILES_DISTRO="$distro" DOTFILES_DISTRO_LIKE='ubuntu debian'
            run chezmoi execute-template --init --source "${ROOT_DIR}/home" \
                --promptString email=test@example.com --promptString "system=$system" \
                --file "${ROOT_DIR}/home/.chezmoiscripts/linux/run_once_before_50-common-dependencies.sh.tmpl"
            [ "$status" -eq 0 ]
            [[ "$output" == *apt-get* ]]
            [[ "$output" != *'omarchy pkg add'* ]]
        done
    done
    export DOTFILES_DISTRO=debian DOTFILES_DISTRO_LIKE=none
    run render home/.chezmoiscripts/linux/run_once_before_50-common-dependencies.sh.tmpl
    [ "$status" -eq 0 ]
    [[ "$output" == *apt-get* ]]
}

@test "unsupported Linux and plain Arch are rejected without Omarchy desktop ownership" {
    local distro
    for distro in fedora arch; do
        export DOTFILES_DISTRO="$distro" DOTFILES_DISTRO_LIKE="$distro"
        run render home/.chezmoiscripts/linux/run_once_before_50-common-dependencies.sh.tmpl
        [ "$status" -ne 0 ]
        [[ "$output" == *'Invalid linux distribution:'* ]]
        run render home/.chezmoiignore
        [ "$status" -eq 0 ]
        [[ "$output" == *'.config/hypr'* ]]
    done
}

@test "Ghostty preserves Omarchy themes and excludes macOS settings" {
    run render home/dot_config/ghostty/config.tmpl
    [ "$status" -eq 0 ]
    [[ "$output" == *'~/.local/state/omarchy/current/theme/ghostty.conf'* ]]
    [[ "$output" == *'async-backend = epoll'* ]]
    [[ "$output" != *macos-icon* ]]
    [[ "$output" != *'background = #353535'* ]]
    run render home/.chezmoiignore
    [ "$status" -eq 0 ]
    [[ "$output" != *'.config/hypr'* ]]
}

@test "macOS and Ubuntu retain existing Ghostty settings and exclude Hyprland" {
    local os
    for os in darwin linux; do
        export DOTFILES_OS="$os" DOTFILES_DISTRO=ubuntu DOTFILES_DISTRO_LIKE=debian
        run render home/dot_config/ghostty/config.tmpl
        [ "$status" -eq 0 ]
        [[ "$output" == *'theme = Gruvbox Dark'* ]]
        [[ "$output" != *'~/.local/state/omarchy'* ]]
        run render home/.chezmoiignore
        [ "$status" -eq 0 ]
        [[ "$output" == *'.config/hypr'* ]]
    done
    export DOTFILES_OS=darwin
    run render home/.chezmoiscripts/linux/run_once_before_50-common-dependencies.sh.tmpl
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

install_package_stub() {
    cat >"${TEST_BIN}/omarchy" <<'EOF'
#!/bin/bash
[[ "$1 $2" == 'pkg add' ]] || exit 2
[[ ${PACKAGE_FAILURE:-false} != true ]] || exit 7
shift 2
for package in "$@"; do
    if [[ ! -e "$INSTALLED_PACKAGES/$package" ]]; then
        printf '%s\n' "$package" >>"$CALL_LOG"
        : >"$INSTALLED_PACKAGES/$package"
    fi
done
EOF
    chmod +x "${TEST_BIN}/omarchy"
}

@test "prerequisites reuse Mise and repeated installation adds nothing" {
    install_package_stub
    printf '#!/bin/bash\n' >"${TEST_BIN}/mise"
    chmod +x "${TEST_BIN}/mise"
    run env PATH="${TEST_BIN}" /bin/bash "${ROOT_DIR}/install/linux/omarchy/dependencies.sh"
    [ "$status" -eq 0 ]
    [ "$(<"$CALL_LOG")" = $'curl\ngit\nzsh\nvim\ntmux\nopenssh\nunzip\nbase-devel' ]
    local first_install
    first_install="$(<"$CALL_LOG")"
    run env PATH="${TEST_BIN}" /bin/bash "${ROOT_DIR}/install/linux/omarchy/dependencies.sh"
    [ "$status" -eq 0 ]
    [ "$(<"$CALL_LOG")" = "$first_install" ]
}

@test "prerequisites install missing Mise and propagate package failures" {
    install_package_stub
    run env PATH="${TEST_BIN}" /bin/bash "${ROOT_DIR}/install/linux/omarchy/dependencies.sh"
    [ "$status" -eq 0 ]
    [[ "$(<"$CALL_LOG")" == *$'\nmise' ]]
    run env PATH="${TEST_BIN}" PACKAGE_FAILURE=true /bin/bash "${ROOT_DIR}/install/linux/omarchy/dependencies.sh"
    [ "$status" -eq 7 ]
}

@test "non-interactive Bash skips prompt tools and retains Omarchy environment" {
    run env HOME="${BATS_TEST_TMPDIR}" PATH=/nonexistent /bin/bash --noprofile --norc -c \
        'source "$1"; [[ -z ${PS1:-} ]]; ! declare -F pko; if [[ -r /usr/share/omarchy/default/bash/env-bootstrap ]]; then [[ -n $OMARCHY_PATH && $PATH == *mise/shims* ]]; fi' \
        bash "${ROOT_DIR}/home/dot_bashrc"
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "interactive Bash activates Mise once and keeps local overrides" {
    printf 'export DOTFILES_LOCAL_MARKER=loaded\n' >"${BATS_TEST_TMPDIR}/.localrc"
    run env HOME="${BATS_TEST_TMPDIR}" TERM=dumb /bin/bash --noprofile --norc -ic \
        'mise() { printf "%s\n" "$*" >>"$CALL_LOG"; }; source "$1"; [[ $HISTCONTROL == ignoreboth && $HISTSIZE == 32768 && $DOTFILES_LOCAL_MARKER == loaded ]]; shopt -q histappend' \
        bash "${ROOT_DIR}/home/dot_bashrc"
    [ "$status" -eq 0 ]
    [ "$(<"$CALL_LOG")" = 'activate bash' ]
}

@test "interactive Bash tolerates absent Mise and optional tools" {
    run env HOME="${BATS_TEST_TMPDIR}" PATH=/nonexistent TERM=dumb /bin/bash --noprofile --norc -ic \
        'source "$1"; [[ $HISTSIZE == 32768 ]]' bash "${ROOT_DIR}/home/dot_bashrc"
    [ "$status" -eq 0 ]
    [[ "$output" != *'mise: command not found'* ]]
}
