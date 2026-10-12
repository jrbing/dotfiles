#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
	set -x
fi

# Repository subscriptions only. Refresh installed skill content explicitly with
# `mise exec -- npx --yes skills@latest update --global --yes`.
for source in mattpocock/skills jrbing/agent-skills; do
	mise exec -- npx --yes skills@latest add "${source}" \
		--global --agent claude-code --agent codex --agent opencode \
		--skill '*' --yes
done
