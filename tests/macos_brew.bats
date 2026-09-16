#!/usr/bin/env bats

setup() {
    export TEST_BIN="${BATS_TEST_TMPDIR}/bin"
    export CALL_LOG="${BATS_TEST_TMPDIR}/calls"

    /bin/mkdir -p "${TEST_BIN}"
    : > "${CALL_LOG}"

    /bin/cat > "${TEST_BIN}/brew" <<'EOF2'
#!/bin/bash
printf 'brew %s\n' "$*" >> "${CALL_LOG}"
[[ "$1" == "list" ]] && exit 1
exit 0
EOF2
    /bin/chmod +x "${TEST_BIN}/brew"
    export PATH="${TEST_BIN}:${PATH}"
}

# Regression: bash 3.2 errors on "${empty[@]}" under set -u.
@test "formula install works under set -u on bash 3.2" {
    run /bin/bash -c "set -Eeuo pipefail
        source '${BATS_TEST_DIRNAME}/../install/macos/common/brew_packages.sh'
        install_brew_packages formula aria2"
    [ "$status" -eq 0 ]
    grep -qx 'brew install --force aria2' "${CALL_LOG}"
}

@test "cask install still passes --cask" {
    run /bin/bash -c "set -Eeuo pipefail
        source '${BATS_TEST_DIRNAME}/../install/macos/common/brew_packages.sh'
        install_brew_packages cask alfred"
    [ "$status" -eq 0 ]
    grep -qx 'brew install --cask --force alfred' "${CALL_LOG}"
}
