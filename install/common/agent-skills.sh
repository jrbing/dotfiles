#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
	set -x
fi

mise exec -- npx --yes skills@latest add mattpocock/skills \
	--global --agent opencode --skill '*' --yes
