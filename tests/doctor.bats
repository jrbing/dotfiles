#!/usr/bin/env bats

setup() {
    export TEST_BIN="${BATS_TEST_TMPDIR}/bin"
    export TEST_HOME="${BATS_TEST_TMPDIR}/home"
    export CALL_LOG="${BATS_TEST_TMPDIR}/calls"

    /bin/mkdir -p "${TEST_BIN}" "${TEST_HOME}"
    : > "${CALL_LOG}"
}

install_mise_stub() {
    /bin/cat > "${TEST_BIN}/mise" <<'EOF'
#!/usr/bin/env bash
case "$1" in
    ls) printf '%s\n' "${MISE_MISSING:-}" ;;
    exec)
        printf 'mise %s\n' "$*" >> "${CALL_LOG}"
        printf '%s\n' "${MISE_VERIFY_OUTPUT:-}"
        [ "${MISE_VERIFY_FAIL:-}" != true ]
        ;;
esac
EOF
    /bin/chmod +x "${TEST_BIN}/mise"
}

install_sheldon_stub() {
    /bin/cat > "${TEST_BIN}/sheldon" <<'EOF'
#!/usr/bin/env bash
EOF
    /bin/chmod +x "${TEST_BIN}/sheldon"
}

@test "doctor verifies bootstrap tooling and managed files" {
    install_mise_stub
    install_sheldon_stub

    run env HOME="${TEST_HOME}" PATH="${TEST_BIN}:/bin:/usr/bin" CALL_LOG="${CALL_LOG}" \
        make --no-print-directory -C "${BATS_TEST_DIRNAME}/.." doctor

    [ "${status}" -eq 0 ]
    [ "$(<"${CALL_LOG}")" = 'mise exec -- chezmoi verify' ]
}

@test "doctor identifies missing Mise" {
    run env HOME="${TEST_HOME}" PATH="${TEST_BIN}:/bin:/usr/bin" \
        make --no-print-directory -C "${BATS_TEST_DIRNAME}/.." doctor

    [ "${status}" -ne 0 ]
    [[ "${output}" == *'Missing bootstrap tool: mise'* ]]
    [[ "${output}" == *'make bootstrap-mise'* ]]
}

@test "bootstrap-mise does not require Mise" {
    /bin/cat > "${TEST_BIN}/curl" <<'EOF'
#!/usr/bin/env bash
cat <<'SCRIPT'
mkdir -p "$HOME/.local/bin"
: > "$HOME/.local/bin/mise"
chmod +x "$HOME/.local/bin/mise"
SCRIPT
EOF
    /bin/chmod +x "${TEST_BIN}/curl"

    run env HOME="${TEST_HOME}" PATH="${TEST_BIN}:/bin:/usr/bin" \
        make --no-print-directory -C "${BATS_TEST_DIRNAME}/.." bootstrap-mise

    [ "${status}" -eq 0 ]
    [ -x "${TEST_HOME}/.local/bin/mise" ]
}

@test "doctor identifies missing Sheldon" {
    install_mise_stub

    run env HOME="${TEST_HOME}" PATH="${TEST_BIN}:/bin:/usr/bin" \
        make --no-print-directory -C "${BATS_TEST_DIRNAME}/.." doctor

    [ "${status}" -ne 0 ]
    [[ "${output}" == *'Missing bootstrap tool: sheldon'* ]]
    [[ "${output}" == *'make bootstrap-sheldon'* ]]
}

@test "doctor identifies missing Mise tools with the bootstrap age gate" {
    install_mise_stub
    install_sheldon_stub

    run env HOME="${TEST_HOME}" PATH="${TEST_BIN}:/bin:/usr/bin" MISE_MISSING='node@lts' \
        make --no-print-directory -C "${BATS_TEST_DIRNAME}/.." doctor

    [ "${status}" -ne 0 ]
    [[ "${output}" == *'Missing Mise tools:'* ]]
    [[ "${output}" == *'mise install --before 7d'* ]]
}

@test "doctor reports a managed-file recovery when verification fails" {
    install_mise_stub
    install_sheldon_stub

    run env HOME="${TEST_HOME}" PATH="${TEST_BIN}:/bin:/usr/bin" CALL_LOG="${CALL_LOG}" MISE_VERIFY_FAIL=true MISE_VERIFY_OUTPUT='managed file mismatch' \
        make --no-print-directory -C "${BATS_TEST_DIRNAME}/.." doctor

    [ "${status}" -ne 0 ]
    [[ "${output}" == *'Repair managed-file drift with: make update'* ]]
    [ "$(<"${CALL_LOG}")" = 'mise exec -- chezmoi verify' ]
}

@test "doctor reports configuration-template recovery separately" {
    install_mise_stub
    install_sheldon_stub

    run env HOME="${TEST_HOME}" PATH="${TEST_BIN}:/bin:/usr/bin" CALL_LOG="${CALL_LOG}" MISE_VERIFY_FAIL=true MISE_VERIFY_OUTPUT='chezmoi: warning: config file template has changed, run chezmoi init to regenerate config file' \
        make --no-print-directory -C "${BATS_TEST_DIRNAME}/.." doctor

    [ "${status}" -ne 0 ]
    [[ "${output}" == *'Repair configuration-template drift with: make init'* ]]
    [[ "${output}" != *'Repair managed-file drift with: make update'* ]]
    [ "$(<"${CALL_LOG}")" = 'mise exec -- chezmoi verify' ]
}
