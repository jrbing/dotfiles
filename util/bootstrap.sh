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

set -e          # Exit immediately on error
set -u          # Treat unset variables as an error
set -o pipefail # Prevent errors in a pipeline from being masked
IFS=$'\n\t'     # Set the internal field separator to a tab and newline

readonly PROGNAME="$(basename $0)"
readonly PROGDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${PROGDIR}/../share/lib/bash-functions.sh"
source "${PROGDIR}/homebrew.sh"

function install_homebrew() {
  echoinfo "Installing homebrew"
  if ! command -v brew &>/dev/null; then
    echoinfo "Installing Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    echoinfo "Homebrew already installed"
  fi
}

function update_homebrew() {
  echoinfo "Updating Homebrew formulas"
  brew update
}

function install_taps() {
  echoinfo "Installing additional Homebrew taps"
  brew tap "${TAPS[@]}"
}

function install_formulas() {
  echoinfo "Installing homebrew formulas"
  brew install "${FORMULAS[@]}"
}

function install_casks() {
  echoinfo "Installing homebrew casks"
  brew cask "${CASKS[@]}"
}

function cleanup_homebrew() {
  echoinfo "Cleaning up homebrew formulas and casks"
  brew cleanup && brew cask cleanup
}

function change_shell() {
  #sudo echo "/usr/local/bin/zsh" >> /etc/shells && chsh -s /usr/local/bin/zsh
  echoinfo "Changing shell to zsh"
  chsh -s /usr/local/bin/zsh
}

#function install_ruby() {
  #echoinfo "Installing Ruby $RUBY_VERSION"
  #rbenv install "$RUBY_VERSION"
#}

#function default_ruby() {
  #echoinfo "Setting $RUBY_VERSION as global default Ruby"
  #rbenv global "$RUBY_VERSION"
  #rbenv rehash
#}

#function update_rubygems() {
  #echoinfo "Updating to latest Rubygems version"
  #gem update --system
#}

#function install_gems() {
  #echoinfo "Installing regularly used ruby gems"
  #gem install bundler --no-document
  #gem install thor --no-document
  #gem install pry --no-document
#}

#function configure_bundler() {
  #echoinfo "Configuring Bundler for parallel gem installation"
  #local number_of_cores=$(sysctl -n hw.ncpu)
  #bundle config --global jobs $((number_of_cores - 1))
#}

install_homebrew
update_homebrew
install_taps
install_formulas
install_casks
cleanup_homebrew

#install_ruby
#default_ruby
#update_rubygems
#install_gems
#configure_bundler

#change_shell
