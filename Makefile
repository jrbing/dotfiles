#===============================================================================
# vim: softtabstop=4 shiftwidth=4 noexpandtab fenc=utf-8 spelllang=en nolist
#===============================================================================

SHELL := /bin/bash

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
	mise exec -- chezmoi init --apply --verbose

update:  ## Update dotfiles from the source repository
	mise exec -- chezmoi apply --verbose

watch:  ## Watch for changes and apply dotfiles automatically
	DOTFILES_DEBUG=1 watchexec -- chezmoi apply --verbose

reset:  ## Reset chezmoi state (removes all stored state data)
	mise exec -- chezmoi state delete-bucket --bucket=scriptState

bootstrap-mise:  ## Install Mise without requiring an existing Mise or Chezmoi
	@curl https://mise.run | sh

bootstrap-sheldon:  ## Install Sheldon without requiring Chezmoi
	@curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh | bash -s -- --repo rossmacarthur/sheldon --to "$$HOME/.local/bin" --force

reset-config:  ## Reset chezmoi configuration (removes all stored configuration data)
	chezmoi init --data=false

###############
#  Validation #
###############

# ponytail: skip legacy bash-functions.sh; shfmt cannot parse its let syntax, while bash -n still validates it.
check:  ## Run shell, template, and Bats validation checks
	@command -v bats >/dev/null || { echo "bats is required for make check" >&2; exit 1; }
	@command -v chezmoi >/dev/null || { echo "chezmoi is required for make check" >&2; exit 1; }
	@echo "Running Bats tests..."
	@bats tests
	@echo "Checking shell syntax..."
	@while IFS= read -r -d '' script; do bash -n "$$script"; done < <(git ls-files -z -- '*.sh')
	@if command -v shellcheck >/dev/null; then \
		echo "Running ShellCheck..."; \
		git ls-files -z -- '*.sh' | xargs -0 shellcheck --severity=error; \
	else \
		echo "ShellCheck not installed; skipping"; \
	fi
	@if command -v shfmt >/dev/null; then \
		echo "Running shfmt..."; \
		while IFS= read -r -d '' script; do shfmt --to-json --filename "$$script" <"$$script" >/dev/null; done < <(git ls-files -z -- '*.sh' ':!home/dot_local/lib/bash/bash-functions.sh'); \
	else \
		echo "shfmt not installed; skipping"; \
	fi
	@echo "Rendering Chezmoi templates..."
	@while IFS= read -r -d '' template; do \
		chezmoi execute-template --init --source home \
			--promptString email=ci@example.com \
			--promptString system=client \
			--file "$$template" >/dev/null; \
	done < <(git ls-files -z -- '*.tmpl')

doctor:  ## Verify managed files and bootstrap tooling
	@bash scripts/doctor.sh

##########
#  Misc  #
##########

help:  ## Show this help menu
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: help docker bootstrap-mise bootstrap-sheldon reset-config reset watch update init check doctor
