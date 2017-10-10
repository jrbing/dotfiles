#!/usr/bin/env bash
# vim: softtabstop=2 shiftwidth=2 expandtab fenc=utf-8 spelllang=en ft=sh
# shellcheck disable=2034

# Homebrew taps
TAPS=(
  homebrew/binary
  homebrew/completions
  homebrew/dupes
  homebrew/services
  caskroom/cask
  buo/cask-upgrade
  kryptco/tap
  moncho/dry
  neovim/neovim
  yudai/gotty
)

# Homebrew Formulas
FORMULAS=(
  ack
  ansible
  ansible-cmdb
  ansible-lint
  aria2
  astyle
  bash
  blink1
  cheat
  clipper
  cmake
  coreutils
  ctags
  ctop
  curl
  docker-completion
  direnv
  dry
  editorconfig
  findutils
  git
  git-flow-avh
  git-lfs
  glide
  go
  gpg-agent
  gradle
  grep
  htop
  hub
  hugo
  imagemagick
  jq
  keybase
  kr
  macvim --with-override-system-vim
  mas
  md5sha1sum
  mosh
  neovim
  openssl
  optipng
  packer
  packer-completion
  pandoc
  pigz
  pinentry
  pinentry-mac
  python
  python3
  rbenv
  readline
  reattach-to-user-namespace
  rlwrap
  rsync
  ruby-build
  shellcheck
  sassc
  shellcheck
  sqlite
  ssh-copy-id
  terraform
  the_silver_searcher
  tldr
  tmux
  tmuxinator-completion
  tree
  watchman
  wget
  yank
  yarn
  zopfli
  zsh
)

# Homebrew casks
CASKS=(
  basictex
  vagrant
  virtualbox
  xquartz
)
