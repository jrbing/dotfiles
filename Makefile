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

##########
#  Misc  #
##########

help:  ## Show this help menu
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: help docker reset-config reset watch update init
