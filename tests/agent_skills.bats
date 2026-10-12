#!/usr/bin/env bats

readonly ROOT_DIR="$(cd "${BATS_TEST_DIRNAME}/.." && pwd)"
readonly TEMPLATE="${ROOT_DIR}/home/.chezmoiscripts/common/run_onchange_after_03-install-agent-skills.sh.tmpl"

setup() {
    TEST_DIR="$(mktemp -d)"
    mkdir -p "${TEST_DIR}/bin"

    cat >"${TEST_DIR}/bin/mise" <<'EOF'
#!/usr/bin/env bash
printf '%s\n' "$*" >>"${MISE_LOG}"
EOF
    chmod +x "${TEST_DIR}/bin/mise"

    MISE_LOG="${TEST_DIR}/mise.log"
    export MISE_LOG
    PATH="${TEST_DIR}/bin:${PATH}"
    export PATH
}

teardown() {
    rm -rf "${TEST_DIR}"
}

render_and_run() {
    DOTFILES_SYSTEM="$1" chezmoi execute-template --init --source "${ROOT_DIR}/home" \
        --promptString email=test@example.com --file "${TEMPLATE}" | bash
}

@test "client installs both declared sources for all three agents" {
    run render_and_run client

    [ "${status}" -eq 0 ]
    [ "$(cat "${MISE_LOG}")" = $'exec -- npx --yes skills@latest add mattpocock/skills --global --agent claude-code --agent codex --agent opencode --skill * --yes\nexec -- npx --yes skills@latest add jrbing/agent-skills --global --agent claude-code --agent codex --agent opencode --skill * --yes' ]
}

@test "server applies install no agent skills" {
    run render_and_run server

    [ "${status}" -eq 0 ]
    [ ! -s "${MISE_LOG}" ]
}

@test "subscription installer stays a run_onchange script" {
    [[ "${TEMPLATE}" == *run_onchange* ]]
}

@test "chezmoi does not manage skills CLI generated directories" {
    [ ! -e "${ROOT_DIR}/home/dot_claude/skills" ]
    [ ! -e "${ROOT_DIR}/home/dot_agents/skills" ]
    [ ! -e "${ROOT_DIR}/home/dot_config/opencode/skills" ]
}
