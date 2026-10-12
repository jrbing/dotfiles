#!/usr/bin/env bats

# shellcheck disable=SC2030,SC2031
# shellcheck source=../install/macos/common/mac_app_store.sh
readonly SCRIPT_PATH="${BATS_TEST_DIRNAME}/../install/macos/common/mac_app_store.sh"

setup() {
    export TEST_BIN="${BATS_TEST_TMPDIR}/bin"
    /bin/mkdir -p "${TEST_BIN}"
    unset DOTFILES_DEBUG
}

@test "is_mas_installed is false when mas is absent" {
    run /bin/bash -c "export PATH='${TEST_BIN}'; source '${SCRIPT_PATH}'; is_mas_installed"

    [ "${status}" -eq 1 ]
}

@test "is_mas_installed is true when mas is on PATH" {
    /bin/cat >"${TEST_BIN}/mas" <<'EOF'
#!/bin/bash
exit 0
EOF
    /bin/chmod +x "${TEST_BIN}/mas"

    run /bin/bash -c "export PATH='${TEST_BIN}'; source '${SCRIPT_PATH}'; is_mas_installed"

    [ "${status}" -eq 0 ]
}
