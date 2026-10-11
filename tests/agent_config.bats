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

@test "shared guidance is exposed to both agents without duplication" {
    [ -f "${ROOT_DIR}/home/dot_agents/AGENTS.md" ]
    grep -q '@~/.agents/AGENTS.md' "${ROOT_DIR}/home/dot_claude/CLAUDE.md"
    [ -f "${ROOT_DIR}/home/dot_codex/symlink_AGENTS.md.tmpl" ]
    [ -f "${ROOT_DIR}/AGENTS.md" ]
}

@test "Codex guidance symlink resolves to the shared file" {
    run chezmoi execute-template --init --source "${ROOT_DIR}/home" \
        --file "${ROOT_DIR}/home/dot_codex/symlink_AGENTS.md.tmpl"

    [ "$status" -eq 0 ]
    [[ "$output" == *'/.agents/AGENTS.md' ]]
}

@test "rendered Claude and Codex configurations parse" {
    python3 -c 'import json, sys; json.load(open(sys.argv[1]))' \
        "${ROOT_DIR}/home/dot_claude/settings.json"
    python3 -c 'import sys, tomllib; tomllib.load(open(sys.argv[1], "rb"))' \
        "${ROOT_DIR}/home/dot_codex/config.toml"
}
