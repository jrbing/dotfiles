#===============================================================================
# vim: softtabstop=4 shiftwidth=4 noexpandtab fenc=utf-8 spelllang=en nolist
#===============================================================================

DOCKER_IMAGE_NAME=dotfiles
DOCKER_ARCH=x86_64
DOCKER_NUM_CPU=4
DOCKER_RAM_GB=4

############
#  Docker  #
############

docker:  ## Run a Docker container with Chezmoi environment
	@if ! docker inspect $(DOCKER_IMAGE_NAME) &>/dev/null; then \
		docker build -t $(DOCKER_IMAGE_NAME) . --build-arg USERNAME="$$(whoami)"; \
	fi
	docker run -it -v "$$(pwd):/home/$$(whoami)/.local/share/chezmoi" dotfiles /bin/bash --login

#############
#  Chezmoi  #
#############

init:  ## Initialize chezmoi and apply dotfiles
	chezmoi init --apply --verbose

update:  ## Update dotfiles from the source repository
	chezmoi apply --verbose

watch:  ## Watch for changes and apply dotfiles automatically
	DOTFILES_DEBUG=1 watchexec -- chezmoi apply --verbose

reset:  ## Reset chezmoi state (removes all stored state data)
	chezmoi state delete-bucket --bucket=scriptState

reset-config:  ## Reset chezmoi configuration (removes all stored configuration data)
	chezmoi init --data=false

#############
#  VM Test  #
#############

VM_NAME ?= dotfiles-test
VM_IMAGE ?= ghcr.io/cirruslabs/macos-tahoe-base:latest

.PHONY: vm-init vm-clone vm-run vm-run-headless vm-ip vm-stop vm-delete vm-list vm-test

vm-init: vm-clone  ## (deprecated) Alias for vm-clone

vm-clone:  ## Clone a macOS Tahoe VM image for testing (one-time, ~25GB download)
	tart clone $(VM_IMAGE) $(VM_NAME)

vm-run:  ## Run the VM with a graphical console window
	tart run $(VM_NAME)

vm-run-headless:  ## Run the VM in headless mode (no GUI)
	tart run --no-graphics $(VM_NAME)

vm-ip:  ## Show the VM's IP address
	@tart ip $(VM_NAME) 2>/dev/null || { echo "VM '$(VM_NAME)' is not running"; exit 1; }

vm-stop:  ## Gracefully shut down the VM
	@IP=$$(tart ip $(VM_NAME) 2>/dev/null) && \
		ssh admin@$$IP "sudo shutdown -h now" 2>/dev/null || \
		echo "VM '$(VM_NAME)' is not running or unreachable"

vm-delete:  ## Delete the VM
	@tart delete $(VM_NAME) 2>/dev/null || echo "VM '$(VM_NAME)' not found"

vm-list:  ## List all Tart VMs
	tart list

vm-test:  ## Automated test: boot VM, run dotfiles setup, then clean up
	@bash scripts/vm-test.sh

##########
#  Misc  #
##########

help:  ## Show this help menu
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: help docker vm-clone vm-run vm-run-headless vm-ip vm-stop vm-delete vm-list vm-test reset-config reset watch update init
