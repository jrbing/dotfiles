#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
	set -x
fi

readonly REPOS=(
    mattpocock/skills
    obra/superpowers
    DietrichGebert/ponytail
    jrbing/agent-skills
)

# Repository subscriptions only. Refresh installed skill content explicitly with
# `mise exec -- npx --yes skills@latest update --global --yes`.
for repo in "${REPOS[@]}"; do
	mise exec -- npx --yes skills@latest add "${repo}" \
		--global --agent claude-code --agent codex --agent opencode \
		--skill '*' --yes
done
