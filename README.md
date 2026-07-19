# dotfiles

Bootstrap a macOS or Linux box from bare OS to a configured shell environment in one command. Manages zsh, vim, tmux, git, and runtime versions with chezmoi.

## Features

- Single-command bootstrap from bare OS to configured environment
- Declarative dotfile management with [chezmoi](https://chezmoi.io)
- Zsh plugin management via [Sheldon](https://sheldon.cli.rs)
- Runtime tool versioning with [mise](https://mise.jdx.dev)
- Package management via [Homebrew](https://brew.sh) (macOS) / apt (Linux)
- Cross-platform: macOS (native) and Linux (Docker / VM test)
- Automated VM testing with Apple Silicon Tart VMs
- 20+ custom utility scripts in `~/.local/bin`
- Vim, tmux, and git configuration included

## Prerequisites

- macOS (Sonoma+) or Linux (Ubuntu 22.04+)
- `curl` and `git`
- Internet connection
- Sudo access (password prompted during bootstrap)

## Installation & Setup

```bash
curl -fsSL https://raw.githubusercontent.com/jrbing/dotfiles/main/setup.sh | bash
```

This will:

1. Detect your OS (macOS/Linux)
2. Install Homebrew (macOS) if missing
3. Download and run chezmoi
4. Initialize the dotfiles source directory from this repo
5. Apply all configurations to `$HOME`
6. Purge the temporary chezmoi binary

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
make watch    # Auto-reapply on file changes (watchexec)
make docker   # Run in Ubuntu Docker container
make reset    # Reset chezmoi script state
```

### VM testing (macOS Apple Silicon)

```bash
make vm-clone          # One-time ~25GB image download
make vm-run            # Boot VM with GUI
make vm-test           # Automated: boot → setup.sh → verify → cleanup
```

## License

MIT License, see [LICENSE](LICENSE).