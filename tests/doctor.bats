#!/usr/bin/env bats

setup() {
    export TEST_BIN="${BATS_TEST_TMPDIR}/bin"
    export CALL_LOG="${BATS_TEST_TMPDIR}/calls"

    /bin/mkdir -p "${TEST_BIN}"
    : > "${CALL_LOG}"
    /bin/cat > "${TEST_BIN}/mise" <<'EOF'
#!/usr/bin/env bash
case "$1" in
    ls) printf '%s\n' "${MISE_MISSING:-}" ;;
    exec) printf 'mise %s\n' "$*" >> "${CALL_LOG}" ;;
esac
EOF
    /bin/chmod +x "${TEST_BIN}/mise"
}

@test "doctor verifies bootstrap tooling and managed files" {
    /bin/cat > "${TEST_BIN}/sheldon" <<'EOF'
#!/usr/bin/env bash
EOF
    /bin/chmod +x "${TEST_BIN}/sheldon"

    run env PATH="${TEST_BIN}:/bin:/usr/bin" CALL_LOG="${CALL_LOG}" \
        make --no-print-directory -C "${BATS_TEST_DIRNAME}/.." doctor

    [ "${status}" -eq 0 ]
    [ "$(<"${CALL_LOG}")" = 'mise exec -- chezmoi verify' ]
}

@test "doctor identifies missing bootstrap tools" {
    run env PATH="${TEST_BIN}:/bin:/usr/bin" \
        make --no-print-directory -C "${BATS_TEST_DIRNAME}/.." doctor

    [ "${status}" -ne 0 ]
    [[ "${output}" == *'Missing bootstrap tools: sheldon'* ]]
    [[ "${output}" == *'make reset && make update'* ]]
}

@test "doctor identifies missing Mise tools" {
    /bin/cat > "${TEST_BIN}/sheldon" <<'EOF'
#!/usr/bin/env bash
EOF
    /bin/chmod +x "${TEST_BIN}/sheldon"

    run env PATH="${TEST_BIN}:/bin:/usr/bin" MISE_MISSING='node@lts' \
        make --no-print-directory -C "${BATS_TEST_DIRNAME}/.." doctor

    [ "${status}" -ne 0 ]
    [[ "${output}" == *'Missing Mise tools:'* ]]
    [[ "${output}" == *'mise install'* ]]
}
