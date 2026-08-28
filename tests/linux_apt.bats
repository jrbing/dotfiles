#!/usr/bin/env bats

setup() {
    export TEST_BIN="${BATS_TEST_TMPDIR}/bin"
    export CALL_LOG="${BATS_TEST_TMPDIR}/calls"

    /bin/mkdir -p "${TEST_BIN}"
    /bin/ln -s /bin/rm "${TEST_BIN}/rm"
    : > "${CALL_LOG}"

    /bin/cat > "${TEST_BIN}/apt-get" <<'EOF'
#!/bin/bash
printf 'apt-get %s\n' "$*" >> "${CALL_LOG}"
if [[ "$1" == "install" && "$2" == "-y" && "$3" == "sudo" ]]; then
    /bin/cat > "${TEST_BIN}/sudo" <<'SUDO'
#!/bin/bash
printf 'sudo %s\n' "$*" >> "${CALL_LOG}"
if [[ "$1" == --preserve-env=* ]]; then
    shift
fi
exec "$@"
SUDO
    /bin/chmod +x "${TEST_BIN}/sudo"
fi
EOF
    /bin/chmod +x "${TEST_BIN}/apt-get"
    export PATH="${TEST_BIN}"
}

install_sudo_stub() {
    /bin/cat > "${TEST_BIN}/sudo" <<'EOF'
#!/bin/bash
printf 'sudo %s\n' "$*" >> "${CALL_LOG}"
if [[ "$1" == --preserve-env=* ]]; then
    shift
fi
exec "$@"
EOF
    /bin/chmod +x "${TEST_BIN}/sudo"
}

@test "apt adapter bootstraps sudo and preserves proxy environment" {
    source "${BATS_TEST_DIRNAME}/../install/linux/common/apt.sh"

    run install_apt_packages curl

    [ "${status}" -eq 0 ]
    [ "$(<"${CALL_LOG}")" = $'apt-get update\napt-get install -y sudo\nsudo --preserve-env=http_proxy,https_proxy,no_proxy apt-get install -y curl\napt-get install -y curl' ]
}

@test "apt adapter uses the shared sudo and proxy path for removal" {
    install_sudo_stub
    source "${BATS_TEST_DIRNAME}/../install/linux/common/apt.sh"

    run uninstall_apt_packages tmux

    [ "${status}" -eq 0 ]
    [ "$(<"${CALL_LOG}")" = $'sudo --preserve-env=http_proxy,https_proxy,no_proxy apt-get remove -y tmux\napt-get remove -y tmux' ]
}

@test "Linux package callers delegate install and removal to the apt adapter" {
    local caller

    for caller in \
        "${BATS_TEST_DIRNAME}/../install/linux/common/ssh.sh" \
        "${BATS_TEST_DIRNAME}/../install/linux/common/tmux.sh" \
        "${BATS_TEST_DIRNAME}/../install/linux/common/misc.sh" \
        "${BATS_TEST_DIRNAME}/../install/linux/common/docker.sh"; do
        /bin/grep -q 'install_apt_packages' "${caller}"
        /bin/grep -q 'uninstall_apt_packages' "${caller}"
        ! /bin/grep -Eq 'sudo( --preserve-env=[^ ]+)? apt-get' "${caller}"
    done
}

@test "Linux package templates include the shared apt adapter" {
    local template

    for template in \
        "${BATS_TEST_DIRNAME}/../home/.chezmoiscripts/linux/run_once_before_50-common-dependencies.sh.tmpl" \
        "${BATS_TEST_DIRNAME}/../home/.chezmoiscripts/linux/run_once_00-setup-ssh.sh.tmpl" \
        "${BATS_TEST_DIRNAME}/../home/.chezmoiscripts/linux/run_once_08-install-tmux.sh.tmpl" \
        "${BATS_TEST_DIRNAME}/../home/.chezmoiscripts/linux/run_once_10-install-docker.sh.tmpl" \
        "${BATS_TEST_DIRNAME}/../home/.chezmoiscripts/linux/run_once_50-install-misc.sh.tmpl"; do
        /bin/grep -q 'include "../install/linux/common/apt.sh"' "${template}"
    done
}

@test "representative package callers execute through the adapter" {
    install_sudo_stub
    source "${BATS_TEST_DIRNAME}/../install/linux/common/ssh.sh"

    run install_openssh
    [ "${status}" -eq 0 ]
    run uninstall_openssh
    [ "${status}" -eq 0 ]
    [ "$(<"${CALL_LOG}")" = $'sudo --preserve-env=http_proxy,https_proxy,no_proxy apt-get install -y openssh-client\napt-get install -y openssh-client\nsudo --preserve-env=http_proxy,https_proxy,no_proxy apt-get remove -y openssh-client\napt-get remove -y openssh-client' ]
}

@test "package caller executes when invoked by a bare filename" {
    install_sudo_stub

    run /bin/bash -c 'cd "$1" && /bin/bash tmux.sh' _ "${BATS_TEST_DIRNAME}/../install/linux/common"

    [ "${status}" -eq 0 ]
    [ "$(<"${CALL_LOG}")" = $'sudo --preserve-env=http_proxy,https_proxy,no_proxy apt-get install -y tmux\napt-get install -y tmux' ]
}

@test "Linux dependency installation filters commands already on PATH" {
    install_sudo_stub
    /bin/ln -s /bin/true "${TEST_BIN}/curl"
    /bin/ln -s /bin/true "${TEST_BIN}/git"
    source "${BATS_TEST_DIRNAME}/../install/linux/common/dependencies.sh"

    run install_linux_dependencies

    [ "${status}" -eq 0 ]
    [ "$(<"${CALL_LOG}")" = $'sudo --preserve-env=http_proxy,https_proxy,no_proxy apt-get install -y busybox cmake gpg htop iproute2 iputils-ping unzip vim wget zsh\napt-get install -y busybox cmake gpg htop iproute2 iputils-ping unzip vim wget zsh' ]
}

@test "misc package caller executes through the adapter" {
    install_sudo_stub
    source "${BATS_TEST_DIRNAME}/../install/linux/common/misc.sh"

    run install_misc
    [ "${status}" -eq 0 ]
    run uninstall_misc
    [ "${status}" -eq 0 ]
    [ "$(<"${CALL_LOG}")" = $'sudo --preserve-env=http_proxy,https_proxy,no_proxy apt-get install -y guake gparted\napt-get install -y guake gparted\nsudo --preserve-env=http_proxy,https_proxy,no_proxy apt-get remove -y guake gparted\napt-get remove -y guake gparted' ]
}

@test "Docker package caller executes through the adapter" {
    install_sudo_stub
    source "${BATS_TEST_DIRNAME}/../install/linux/common/docker.sh"

    run install_docker_engine
    [ "${status}" -eq 0 ]
    run uninstall_docker_engine
    [ "${status}" -eq 0 ]
    [ "$(<"${CALL_LOG}")" = $'sudo --preserve-env=http_proxy,https_proxy,no_proxy apt-get update\napt-get update\nsudo --preserve-env=http_proxy,https_proxy,no_proxy apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin\napt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin\nsudo --preserve-env=http_proxy,https_proxy,no_proxy apt-get remove -y docker-ce docker-ce-cli containerd.io docker-compose-plugin\napt-get remove -y docker-ce docker-ce-cli containerd.io docker-compose-plugin' ]
}
