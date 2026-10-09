# dotfiles

Bootstrap a macOS or Linux box from bare OS to a configured shell environment in one command. Manages zsh, vim, tmux, git, and runtime versions with chezmoi.

## Features

- Single-command bootstrap from bare OS to configured environment
- Declarative dotfile management with [chezmoi](https://chezmoi.io)
- Zsh plugin management via [Sheldon](https://sheldon.cli.rs)
- Runtime tool versioning with [mise](https://mise.jdx.dev)
- Package management via [Homebrew](https://brew.sh) (macOS), apt (Ubuntu), and Omarchy's package commands
- Cross-platform: macOS, Ubuntu, and installed Omarchy 4.x systems
- Automated VM testing with Apple Silicon Tart VMs
- 20+ custom utility scripts in `~/.local/bin`
- Vim, tmux, and git configuration included

### Editor support

Vim and Neovim are both supported through separate configurations. Vim uses
`~/.vimrc`; Neovim uses `~/.config/nvim` with LazyVim. Their plugins and
customizations are not shared automatically, so changes to one configuration
must be ported deliberately when equivalent behavior is wanted in the other.

## Prerequisites

- macOS (Sonoma+), Ubuntu 22.04+, or an installed Omarchy 4.x system
- `curl` and `git`
- Internet connection
- Sudo access (password prompted during bootstrap)

## Installation & Setup

```bash
curl -fsSL https://raw.githubusercontent.com/jrbing/dotfiles/main/setup.sh | bash
```

For a reproducible bootstrap, replace `main` with a reviewed commit and pass
the same value to `DOTFILES_REVISION`:

```bash
curl -fsSL https://raw.githubusercontent.com/jrbing/dotfiles/<commit>/setup.sh | DOTFILES_REVISION=<commit> bash
```

Piped and CI installs do not prompt. Set `DOTFILES_EMAIL` and, when needed,
`DOTFILES_SYSTEM=server`; the default system is `client`.

This will:

1. Detect your OS (macOS/Linux)
2. Install Homebrew (macOS) if missing
3. Download and run chezmoi
4. Initialize the dotfiles source directory from this repo
5. Apply all configurations to `$HOME`
6. Purge the temporary chezmoi binary

### Tool ownership

Homebrew, apt, and Omarchy install operating-system prerequisites, including `mise`.
Mise is the only owner of managed runtimes and developer CLIs; its manifest is
`home/dot_config/mise/config.toml`.

On upgraded Linux hosts, `chezmoi apply` installs apt-managed Mise but leaves
existing `~/.local/bin/mise` and `starship` binaries unchanged. After verifying
they came from an older dotfiles install, preserve them outside `PATH`:

```bash
mkdir -p ~/.local/bin/legacy-dotfiles
for tool in mise starship; do
  test -e "${HOME}/.local/bin/${tool}" || test -L "${HOME}/.local/bin/${tool}" || continue
  mv "${HOME}/.local/bin/${tool}" ~/.local/bin/legacy-dotfiles/
done
```

## Usage

### Daily operations

```bash
# Pull remote changes and apply
chezmoi update --verbose

# Re-apply dotfiles after editing source
chezmoi apply --verbose

# Edit a specific file (opens the chezmoi source)
chezmoi edit ~/.zshrc

# See pending changes
chezmoi diff
```

### Makefile targets

```bash
make init      # chezmoi init --apply --verbose
make update   # chezmoi apply --verbose
make check    # Run shell, template, and Bats validation checks
make doctor   # Verify managed files and bootstrap tooling
make watch    # Auto-reapply on file changes (watchexec)
make docker   # Run in Ubuntu Docker container
make reset    # Reset chezmoi script state
```

`chezmoi apply` keeps managed files in sync, but bootstrap package scripts run
only once after succeeding. Run `make doctor` to find drift. Use `make update`
for managed-file drift, `mise install --before 7d` for missing Mise tools,
`make bootstrap-mise` or `make bootstrap-sheldon` for a missing bootstrap
binary, or `make reset && make update` to deliberately replay one-time scripts.

### Omarchy

Install Omarchy first, then use the same dotfiles bootstrap. The repo detects
`ID=omarchy` in `/etc/os-release`; Arch package ancestry alone does not enable
desktop management. Plain Arch and other unsupported Linux distributions fail
with an explicit distribution error.

Omarchy installs only missing prerequisites through `omarchy pkg add`: curl,
git, Zsh, Vim, tmux, OpenSSH, unzip, and base-devel. A working Mise installation
(including Omarchy's `mise-bin`) is reused. Mise is installed only if its command
is missing. Runtime versions, developer CLIs, and Sheldon retain the existing
repo workflow. Docker and desktop applications remain optional Omarchy installs;
use `omarchy update` for system updates. Applying the repo does not change your
login shell; run `zsh` to try the configured shell first.

The repo manages these desktop preferences on Omarchy:

- `~/.config/hypr/input.lua`: left Alt/Super swap, Compose keyboard options,
  natural touchpad scrolling, and three-finger workspace switching.
- `~/.config/ghostty/config`: this host's terminal preferences with the dynamic
  `~/.local/state/omarchy/current/theme/ghostty.conf` include intact.

The Hyprland source directory is ignored on other platforms. Monitor settings
remain local. Omarchy's stock `hyprland.lua` loads the input
override after its defaults. Bar, launcher, branding, generated theme files,
and runtime state are not captured. Nothing under `/usr/share/omarchy` is edited.

Before your first apply, back up overlapping files outside the repo, particularly
your shell startup files, Mise and Neovim configurations, and desktop overrides.
If chezmoi has not been initialized for this checkout, run
`chezmoi init --source "$PWD/home"` without `--apply` first.
Review `chezmoi diff --source "$PWD/home"`; the repo will take ownership of its
existing shell, editor, and developer configurations as well as the two desktop
files above. Keep machine-specific exports in `~/.localrc`. For example, this
host's 1Password SSH agent setting belongs there:

```bash
export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
```

After applying, open fresh Bash and Zsh sessions and confirm expected tool
versions. Validate Hyprland with `hyprctl reload` and `hyprctl configerrors`.
Reload terminals with `omarchy restart terminal`, and check that changing themes
still updates Ghostty's colors. Source-only changes do not need a desktop reload.

To manage more personal desktop files, add individual overrides with
`chezmoi add`, then add their target paths to the non-Omarchy branch of
`home/.chezmoiignore`. Use `chezmoi edit` for subsequent edits. If you change a
file through an Omarchy menu, inspect the change and capture it with
`chezmoi re-add <path>` before applying again. Avoid adding entire config trees:
they can contain backups, generated files, or machine-specific settings.
Custom theme sources belong under `~/.config/omarchy/themes/<name>/`; executable
hooks belong under `~/.config/omarchy/hooks/<event>.d/` and need chezmoi's
`executable_` prefix. Never capture generated files from `~/.local/state/omarchy`.

Bash keeps Omarchy's environment bootstrap even in non-interactive shells,
while history, completion, prompt setup, and Mise activation run interactively.
Zsh also loads the portable bootstrap without importing Omarchy's Bash aliases.
Useful optional additions from Omarchy's Bash defaults are guarded fzf bindings
and file previews, guarded zoxide initialization, and `..`/`...` directory
aliases. These remain suggestions; the repo preserves its existing prompt and
does not load Omarchy's full Bash initialization chain.

For rendering tests, `DOTFILES_OS`, `DOTFILES_DISTRO`, and
`DOTFILES_DISTRO_LIKE` can override platform detection. Leave these unset during
normal application. Detection otherwise uses chezmoi's OS data and distribution
ID/`ID_LIKE` tokens. See `tests/omarchy.bats` for the platform matrix.

### VM testing (macOS Apple Silicon)

```bash
make vm-clone          # One-time ~25GB image download
make vm-run            # Boot VM with GUI
make vm-test           # Automated: boot → setup.sh → verify → cleanup
```

## License

MIT License, see [LICENSE](LICENSE).
