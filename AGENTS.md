# AGENTS.md

Dotfiles repo managed by [chezmoi](https://chezmoi.io). Bootstrapped via `setup.sh` (curl|bash), which installs chezmoi to `~/.local/bin`, runs `chezmoi init` against this repo, then `chezmoi apply`.

## Source layout — read this first

- `.chezmoiroot` contains `home`, so the chezmoi source dir is **`home/`**, not the repo root. All dotfile edits happen under `home/` using chezmoi naming:
  - `dot_*` maps to a dotfile in `$HOME` (e.g. `home/dot_zshrc` → `~/.zshrc`)
  - `executable_*` marks scripts that get `+x` (see `home/dot_local/bin/`)
  - directories like `dot_config/` map to `~/.config/`
- Do **not** edit files at the repo root expecting them to land in `$HOME` — they won't.
- `install/{common,macos,linux}/` are included by chezmoi scripts. Most are `run_once_` bootstrap scripts; only `run_onchange_after_03-install-agent-skills.sh.tmpl` reruns when its content changes.
- Tool chain on a fresh machine: `setup.sh` → chezmoi applies dotfiles → `mise` (runs at shell startup, installs sheldon) → `sheldon` (installs zsh plugins). Don't replicate this wiring manually.

## Common commands

From the repo root:

| Command | Purpose |
|---|---|
| `make init` | `chezmoi init --apply --verbose` from this repo |
| `make update` | `chezmoi apply --verbose` after editing source |
| `make doctor` | Verify managed files and bootstrap tooling; reports the recovery command for drift |
| `make watch` | Re-apply on change via `watchexec` (sets `DOTFILES_DEBUG=1`) |
| `make reset` | Wipe chezmoi `scriptState` bucket when run-scripts mis-fire |
| `make reset-config` | Wipe chezmoi config (`chezmoi init --data=false`) |
| `make docker` | Build/run the Ubuntu container with this repo mounted as the chezmoi source |
| `make vm-test` | Boot a macOS Tahoe Tart VM, run `setup.sh` inside, verify `.zshrc` (see `scripts/vm-test.sh`) |
| `make vm-clone` | One-time ~25GB Tart image clone (prereq for `vm-test`/`vm-run`) |

Target a single chezmoi path: `chezmoi apply ~/.zshrc` or `chezmoi edit ~/.zshrc` (opens the *source* file under `home/`).

## Gotchas

- `NOTES.md` and `TODO.md` are gitignored — scratch files, don't rely on them for canonical info.
- `setup.sh` purges the chezmoi binary it downloads at the end; re-running it re-downloads. Use `make init`/`make update` for iterative work instead.
- macOS bootstrap in `setup.sh` stores a sudo password in the Keychain under the `dotfiles` label and removes it on exit — don't expect passwordless sudo to persist.
- `home/dot_local/bin/` scripts are chezmoi `executable_` entries; keep the prefix when adding new ones or they'll lose the `+x` bit on apply.
- VM tests require `tart` and `sshpass` (the script installs them via brew if missing). First `vm-clone` download is ~25GB.

## Conventions

- Commits follow [Conventional Commits](https://www.conventionalcommits.org/): `feat:`, `fix:`, `docs:`, `chore:`, etc. Optional scope: `fix(vim): ...`. Imperative, present-tense subject, body wrapped at 72.
- Run `make check` before changes; it runs Bats, shell syntax, optional ShellCheck/shfmt, and Chezmoi template rendering. Use `make vm-test` for a full macOS bootstrap.
- `run_once_` scripts do not rerun after a successful apply. Keep them idempotent so `make reset && make update` can deliberately replay bootstrap work; use `make doctor` first to identify the needed recovery path.
