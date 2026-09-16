#!/usr/bin/env bats

readonly ROOT_DIR="$(cd "${BATS_TEST_DIRNAME}/.." && pwd)"

@test "package managers bootstrap Mise and Mise owns managed CLIs" {
    local package

    grep -qx $'\tmise' "${ROOT_DIR}/install/macos/common/dependencies.sh"
    grep -q 'install_apt_packages mise' "${ROOT_DIR}/install/linux/common/dependencies.sh"
    ! grep -q 'mise.run' "${ROOT_DIR}/install/common/mise.sh"
    grep -q 'left unchanged' "${ROOT_DIR}/install/linux/common/mise.sh"
    ! grep -q '\.local/bin/mise' "${ROOT_DIR}/install/common/agent-skills.sh"
    ! grep -q '\.local/bin/mise' "${ROOT_DIR}/home/dot_bashrc"
    grep -q '^mise exec ' "${ROOT_DIR}/install/common/agent-skills.sh"
    grep -q '$(mise activate bash)' "${ROOT_DIR}/home/dot_bashrc"

    for package in gh go kubernetes-cli node opencode starship topgrade; do
        ! grep -Eq "^[[:space:]]*${package}$" "${ROOT_DIR}/install/macos/common/misc.sh"
    done

    grep -q '^go = ' "${ROOT_DIR}/home/dot_config/mise/config.toml"
    grep -q '^node = ' "${ROOT_DIR}/home/dot_config/mise/config.toml"
    grep -q '^kubectl = ' "${ROOT_DIR}/home/dot_config/mise/config.toml"
    grep -q '^opencode = ' "${ROOT_DIR}/home/dot_config/mise/config.toml"
    grep -q '^starship = ' "${ROOT_DIR}/home/dot_config/mise/config.toml"
    grep -q '^topgrade = ' "${ROOT_DIR}/home/dot_config/mise/config.toml"
    grep -q '^"github:cli/cli" = ' "${ROOT_DIR}/home/dot_config/mise/config.toml"

    [ ! -e "${ROOT_DIR}/install/linux/common/starship.sh" ]
    [ ! -e "${ROOT_DIR}/home/.chezmoiscripts/linux/run_once_10-install-starship.sh.tmpl" ]
    [ -e "${ROOT_DIR}/home/.chezmoiscripts/linux/run_onchange_after_02-migrate-mise.sh.tmpl" ]
}
