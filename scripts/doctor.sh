#!/usr/bin/env bash

set -Eeuo pipefail

missing=()
for tool in mise sheldon; do
	command -v "${tool}" >/dev/null 2>&1 || missing+=("${tool}")
done

if [ "${#missing[@]}" -gt 0 ]; then
	printf 'Missing bootstrap tools: %s\n' "${missing[*]}" >&2
	printf 'Repair them with: make reset && make update\n' >&2
	exit 1
fi

if ! missing_mise_tools="$(mise ls --missing --no-header)"; then
	exit 1
fi

if [ -n "${missing_mise_tools}" ]; then
	printf 'Missing Mise tools:\n%s\n' "${missing_mise_tools}" >&2
	printf 'Repair them with: mise install\n' >&2
	exit 1
fi

mise exec -- chezmoi verify
