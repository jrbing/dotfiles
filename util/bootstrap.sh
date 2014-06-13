#!/usr/bin/env bash
#===============================================================================
# vim: softtabstop=2 shiftwidth=2 expandtab fenc=utf-8 spelllang=en ft=sh
#===============================================================================
#
#          FILE: bootstrap.sh
#
#   DESCRIPTION: Script for bootstrapping personal machine for development under
#                OSX
#
#===============================================================================

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

readonly RUBY_VERSION="$(curl -sSL http://ruby.thoughtbot.com/latest)"
readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(readlink -m $(dirname $0))

echoinfo() {
  printf "${GC} *  INFO${EC}: %s\n" "$@";
}

change_shell() {
  echoinfo "Changing shell to zsh"
  chsh -s $(which zsh)
}

clone_dotfiles() {
  git clone git@github.com:jrbing/dotfiles.git $HOME/.dotfiles
  cd $HOME/.dotfiles
}

fix_zsh_bug() {
  if [[ -f /etc/zshenv ]]; then
  echoinfo "Fixing OSX zsh environment bug ..."
    sudo mv /etc/{zshenv,zshrc}
  fi
}

install_homebrew() {
  if ! command -v brew &>/dev/null; then
    echoinfo "Installing Homebrew"
    ruby <(curl -fsS https://raw.githubusercontent.com/Homebrew/homebrew/go/install)
  else
    echoinfo "Homebrew already installed"
  fi
}

update_homebrew() {
  echoinfo "Updating Homebrew formulas"
  brew update
}

install_ruby() {
  echoinfo "Installing Ruby $RUBY_VERSION"
  rbenv install "$RUBY_VERSION"
}

default_ruby() {
  echoinfo "Setting $RUBY_VERSION as global default Ruby"
  rbenv global "$RUBY_VERSION"
  rbenv rehash
}

update_rubygems() {
  echoinfo "Updating to latest Rubygems version ..."
  gem update --system
}

echoinfo "Installing Bundler to install project-specific Ruby gems ..."
  gem install bundler --no-document --pre

echoinfo "Configuring Bundler for faster, parallel gem installation ..."
  number_of_cores=$(sysctl -n hw.ncpu)
  bundle config --global jobs $((number_of_cores - 1))

echoinfo "Installing thor"
  gem install bundler --no-document --pre

echoinfo "Installing the heroku-config plugin to pull config variables locally to be used as ENV variables ..."
  heroku plugins:install git://github.com/ddollar/heroku-config.git
