#!/usr/bin/env bats

readonly ROOT_DIR="$(cd "${BATS_TEST_DIRNAME}/.." && pwd)"

@test "check target includes bootstrap validation stages" {
    run make --no-print-directory -n -C "${ROOT_DIR}" check

    [ "${status}" -eq 0 ]
    [[ "${output}" == *"bats tests"* ]]
    [[ "${output}" == *"bash -n"* ]]
    [[ "${output}" == *"shellcheck"* ]]
    [[ "${output}" == *"xargs -0 shellcheck"* ]]
    [[ "${output}" != *"xargs -0 -r"* ]]
    [[ "${output}" == *"shfmt"* ]]
    [[ "${output}" == *"chezmoi execute-template --init --source home"* ]]
}

@test "notification cache hook renders the installed executable path" {
    run chezmoi execute-template --init --source "${ROOT_DIR}/home" \
        --file "${ROOT_DIR}/home/.chezmoiscripts/common/run_after_99-refresh-chezmoi-notify-cache.sh.tmpl"

    [ "${status}" -eq 0 ]
    [[ "${output}" == *'${HOME}/.local/bin/chezmoi-notify-cache'* ]]
    [[ "${output}" != *'${HOME}/.local/bin/common/chezmoi-notify-cache'* ]]
}
