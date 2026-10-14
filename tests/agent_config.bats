#!/usr/bin/env bats

readonly ROOT_DIR="$(cd "${BATS_TEST_DIRNAME}/.." && pwd)"

render() {
    chezmoi execute-template --init --source "${ROOT_DIR}/home" \
        --promptString email=test@example.com --file "${ROOT_DIR}/$1"
}

@test "client Mise config declares the Claude and Codex CLIs" {
    export DOTFILES_SYSTEM=client
    run render home/dot_config/mise/config.toml.tmpl

    [ "$status" -eq 0 ]
    [[ "$output" == *$'\nclaude = "latest"'* ]]
    [[ "$output" == *$'\ncodex = "latest"'* ]]
    [[ "$output" == *$'\nopencode = "latest"'* ]]
    [[ "$output" == *$'\nminimum_release_age = "7d"'* ]]
    [[ "$output" == *'minimum_release_age_excludes = ["claude", "codex"]'* ]]
}

@test "server Mise config omits the Claude and Codex CLIs" {
    export DOTFILES_SYSTEM=server
    run render home/dot_config/mise/config.toml.tmpl

    [ "$status" -eq 0 ]
    [[ "$output" != *'claude = '* ]]
    [[ "$output" != *'codex = '* ]]
    [[ "$output" == *$'\nopencode = "latest"'* ]]
}

@test "server applies exclude the shared and per-agent directories" {
    export DOTFILES_SYSTEM=server
    run render home/.chezmoiignore

    [ "$status" -eq 0 ]
    [[ "$output" == *$'\n.agents'* ]]
    [[ "$output" == *$'\n.claude'* ]]
    [[ "$output" == *$'\n.codex'* ]]
}

@test "client applies keep the shared and per-agent directories" {
    export DOTFILES_SYSTEM=client
    run render home/.chezmoiignore

    [ "$status" -eq 0 ]
    [[ "$output" != *'.agents'* ]]
    [[ "$output" != *'.claude'* ]]
    [[ "$output" != *'.codex'* ]]
}
