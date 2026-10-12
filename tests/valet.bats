#!/usr/bin/env bats

readonly ROOT_DIR="$(cd "${BATS_TEST_DIRNAME}/.." && pwd)"
readonly VALET="${ROOT_DIR}/home/dot_local/libexec/executable_valet"
readonly GENERATOR="${ROOT_DIR}/home/dot_local/libexec/executable_valet-template"
RUBY_BIN="$({ command -v ruby || mise which ruby; } 2>/dev/null || true)"

setup() {
    export HOME="${BATS_TEST_TMPDIR}/home"
    mkdir -p "${HOME}/.local/libexec"
    cp "${VALET}" "${HOME}/.local/libexec/valet"
    chmod +x "${HOME}/.local/libexec/valet"
    cat >"${HOME}/.local/libexec/valet-hello" <<'SH'
#!/usr/bin/env bash
printf 'hello %s\n' "$*"
SH
    chmod +x "${HOME}/.local/libexec/valet-hello"
}

@test "valet dispatches to the matching valet-* script" {
    run "${HOME}/.local/libexec/valet" hello world

    [ "${status}" -eq 0 ]
    [ "${output}" = "hello world" ]
}

@test "valet lists the available commands" {
    run "${HOME}/.local/libexec/valet"

    [ "${status}" -eq 0 ]
    [[ "${output}" == *"hello"* ]]
}

@test "valet rejects an unknown command" {
    run "${HOME}/.local/libexec/valet" nope

    [ "${status}" -eq 1 ]
    [[ "${output}" == *"no such command"* ]]
}

@test "the valet suite carries no framework or thor dependency" {
    [ ! -e "${ROOT_DIR}/home/dot_local/share/valet/util.rb" ]
    ! grep -rq "executable_valet" "${ROOT_DIR}/home/dot_local/libexec/"
    ! grep -rq "require 'thor'" "${ROOT_DIR}/home/dot_local/libexec/"
}

@test "valet template renders a bundled template" {
    [ -n "${RUBY_BIN}" ] || skip "ruby not installed"
    mkdir -p "${HOME}/.local/share/valet" "${BATS_TEST_TMPDIR}/work"
    cp -r "${ROOT_DIR}/home/dot_local/share/valet/templates" "${HOME}/.local/share/valet/"
    cd "${BATS_TEST_TMPDIR}/work"

    run "${RUBY_BIN}" "${GENERATOR}" bash demo

    [ "${status}" -eq 0 ]
    [ -x demo.sh ]
    grep -q 'FILE: demo.sh' demo.sh
}

@test "valet template rejects an unknown type" {
    [ -n "${RUBY_BIN}" ] || skip "ruby not installed"
    mkdir -p "${HOME}/.local/share/valet"
    cp -r "${ROOT_DIR}/home/dot_local/share/valet/templates" "${HOME}/.local/share/valet/"

    run "${RUBY_BIN}" "${GENERATOR}" bogus

    [ "${status}" -eq 1 ]
    [[ "${output}" == *"unknown type"* ]]
}
