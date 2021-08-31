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

function install_homebrew() {
  echoinfo "Installing homebrew"
  if ! command -v brew &>/dev/null; then
    echoinfo "Installing Homebrew"
    #/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echoinfo "Homebrew already installed"
  fi
}

function update_homebrew() {
  echoinfo "Updating Homebrew formulas"
  brew update
}

function install_from_brewfile() {
  echoinfo "Installing from Brewfile"
  cd ~/.dotfiles && brew bundle
}

function cleanup_homebrew() {
  echoinfo "Cleaning up homebrew formulas and casks"
  brew cleanup
}

function change_shell() {
  #sudo echo "/usr/local/bin/zsh" >> /etc/shells && chsh -s /usr/local/bin/zsh
  echoinfo "Changing shell to zsh"
  chsh -s /usr/local/bin/zsh
}

install_homebrew
update_homebrew
install_from_brewfile
cleanup_homebrew

#change_shell
