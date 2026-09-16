#!/usr/bin/env bash

set -Eeuo pipefail

if ! command -v mise >/dev/null 2>&1; then
	printf 'Missing bootstrap tool: mise\n' >&2
	printf 'Repair it with: make bootstrap-mise\n' >&2
	exit 1
fi

if ! command -v sheldon >/dev/null 2>&1; then
	printf 'Missing bootstrap tool: sheldon\n' >&2
	printf 'Repair it with: make bootstrap-sheldon\n' >&2
	exit 1
fi

if ! missing_mise_tools="$(mise ls --missing --no-header)"; then
	exit 1
fi

if [ -n "${missing_mise_tools}" ]; then
	printf 'Missing Mise tools:\n%s\n' "${missing_mise_tools}" >&2
	printf 'Repair them with: mise install --before 7d\n' >&2
	exit 1
fi

if ! mise exec -- chezmoi verify; then
	printf 'Repair managed-file drift with: make update\n' >&2
	exit 1
fi
