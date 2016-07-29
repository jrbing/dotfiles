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
readonly PROGNAME="$(basename $0)"
source ./homebrew.sh

function echoinfo() {
  printf "${GC} *  INFO${EC}: %s\n" "$@";
}

#sudo echo "/usr/local/bin/zsh" >> /etc/shells && chsh -s /usr/local/bin/zsh
function change_shell() {
  echoinfo "Changing shell to zsh"
  chsh -s "$(which zsh)"
}

# TODO: is this still necessary?
function fix_zsh_bug() {
  if [[ -f /etc/zshenv ]]; then
  echoinfo "Fixing OSX zsh environment bug ..."
    sudo mv /etc/{zshenv,zshrc}
  fi
}

function install_homebrew() {
  if ! command -v brew &>/dev/null; then
    echoinfo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    echoinfo "Homebrew already installed"
  fi
}

function install_brews() {
  brew tap "${TAPS[@]}" && brew install "${FORMULAS[@]}"
  brew cask "${CASKS[@]}" && brew cask alfred link
  brew cleanup && brew cask cleanup
}

function update_homebrew() {
  echoinfo "Updating Homebrew formulas"
  brew update
}

function install_ruby() {
  echoinfo "Installing Ruby $RUBY_VERSION"
  rbenv install "$RUBY_VERSION"
}

function default_ruby() {
  echoinfo "Setting $RUBY_VERSION as global default Ruby"
  rbenv global "$RUBY_VERSION"
  rbenv rehash
}

function update_rubygems() {
  echoinfo "Updating to latest Rubygems version ..."
  gem update --system
}

function install_bundler() {
  echoinfo "Installing Bundler to install project-specific Ruby gems ..."
  gem install bundler --no-document
}

function configure_bundler() {
  echoinfo "Configuring Bundler for faster, parallel gem installation ..."
  number_of_cores=$(sysctl -n hw.ncpu)
  bundle config --global jobs $((number_of_cores - 1))
}

function install_thor() {
  echoinfo "Installing thor"
  gem install thor --no-document
}

change_shell
#fix_zsh_bug
install_homebrew
update_homebrew
install_brews
install_ruby
default_ruby
update_rubygems
install_bundler
configure_bundler
install_thor

#TODO: add rbenv shims to path
