#!/usr/bin/env bash
set -Eeuo pipefail

VM_NAME="${VM_NAME:-dotfiles-test}"
VM_IMAGE="${VM_IMAGE:-ghcr.io/cirruslabs/macos-tahoe-base:latest}"
BRANCH_NAME="${BRANCH_NAME:-main}"
SSH_PASSWORD="${SSH_PASSWORD:-admin}"
SSH_USER="${SSH_USER:-admin}"
TART_PID=""

export CI=true

info()  { printf "\033[1;34m>>\033[0m %s\n" "$*"; }
ok()    { printf "\033[1;32mOK\033[0m %s\n" "$*"; }
err()   { printf "\033[1;31m!!\033[0m %s\n" "$*"; }
die()   { err "$*"; exit 1; }

cleanup() {
    info "Cleaning up..."
    if [ -n "${VM_IP:-}" ]; then
        sshpass -p "$SSH_PASSWORD" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10 \
            "${SSH_USER}@${VM_IP}" "sudo shutdown -h now" 2>/dev/null || true
    fi
    if [ -n "${TART_PID:-}" ]; then
        kill "$TART_PID" 2>/dev/null || true
        wait "$TART_PID" 2>/dev/null || true
    fi
    tart delete "$VM_NAME" 2>/dev/null || true
    ok "Cleanup done"
}
trap cleanup EXIT

check_prereqs() {
    if ! command -v tart &>/dev/null; then
        info "Installing Tart..."
        brew install cirruslabs/cli/tart
    fi
    if ! command -v sshpass &>/dev/null; then
        info "Installing sshpass..."
        brew install hudochenkov/sshpass/sshpass
    fi
    ok "All prerequisites met"
}

clone_vm() {
    if tart list 2>/dev/null | grep -qE "^\S+\s+${VM_NAME}\s"; then
        info "VM '${VM_NAME}' already exists, skipping clone"
        return
    fi
    info "Cloning macOS Tahoe VM image from ${VM_IMAGE} ..."
    info "This will download ~25GB on first run"
    tart clone "$VM_IMAGE" "$VM_NAME"
    ok "VM cloned successfully"
}

boot_vm() {
    info "Booting VM in headless mode..."
    tart run --no-graphics "$VM_NAME" &
    TART_PID=$!
    ok "VM booting (PID: $TART_PID)"
}

wait_for_ip() {
    info "Waiting for VM to boot and get an IP address..."
    for i in $(seq 1 60); do
        VM_IP=$(tart ip "$VM_NAME" 2>/dev/null || true)
        if [ -n "${VM_IP:-}" ]; then
            ok "VM is at ${VM_IP}"
            return 0
        fi
        sleep 5
    done
    die "VM failed to get an IP address within 5 minutes"
}

wait_for_ssh() {
    info "Waiting for SSH to become available..."
    for i in $(seq 1 30); do
        if sshpass -p "$SSH_PASSWORD" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 \
            "${SSH_USER}@${VM_IP}" "echo READY" 2>/dev/null | grep -q READY; then
            ok "SSH ready"
            return 0
        fi
        sleep 2
    done
    die "SSH not available after 60 seconds"
}

run_dotfiles_setup() {
    info "Running dotfiles setup inside the VM..."
    sshpass -p "$SSH_PASSWORD" ssh -o StrictHostKeyChecking=no "${SSH_USER}@${VM_IP}" \
        "curl -fsSL https://raw.githubusercontent.com/jrbing/dotfiles/${BRANCH_NAME}/setup.sh | bash"
    ok "Dotfiles setup completed"
}

verify_dotfiles() {
    info "Verifying dotfiles were applied..."
    local result
    result=$(sshpass -p "$SSH_PASSWORD" ssh -o StrictHostKeyChecking=no "${SSH_USER}@${VM_IP}" \
        "test -f ~/.zshrc && echo 'OK' || echo 'MISSING'" 2>/dev/null || true)
    
    if [ "$result" = "OK" ]; then
        ok "Dotfiles verified successfully (.zshrc found)"
    else
        err ".zshrc not found - dotfiles may not have been fully applied"
        exit 1
    fi
}

main() {
    echo ""
    echo "  macOS VM Test for dotfiles"
    echo "  ========================="
    echo ""
    
    check_prereqs
    clone_vm
    boot_vm
    wait_for_ip
    wait_for_ssh
    run_dotfiles_setup
    verify_dotfiles
    
    echo ""
    ok "All tests passed!"
    echo ""
}

main
