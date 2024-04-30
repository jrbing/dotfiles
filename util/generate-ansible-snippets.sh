#!/usr/bin/env bash
#===============================================================================
# vim: softtabstop=2 shiftwidth=2 expandtab fenc=utf-8 spelllang=en ft=sh
#===============================================================================
#
#          FILE: generate-ansible-snippets.sh
#
#         USAGE: ./generate-ansible-snippets.sh
#
#   DESCRIPTION:
#
#===============================================================================

set -e          # Exit immediately on error
set -u          # Treat unset variables as an error
set -o pipefail # Prevent errors in a pipeline from being masked
IFS=$'\n\t'     # Set the internal field separator to a tab and newline

readonly PROGNAME="$(basename $0)"
readonly PROGDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
readonly ARGS=( "$@" )

###############
#  Functions  #
###############

function echoinfo() {
  local GC="\033[1;32m"
  local EC="\033[0m"
  printf "${GC} ☆  INFO${EC}: %s\n" "$@";
}

function echowarn() {
  local YC="\033[1;33m"
  local EC="\033[0m"
  printf "${YC} ⚠  WARN${EC}: %s\n" "$@";
}

function echodebug() {
  local BC="\033[1;34m"
  local EC="\033[0m"
  if [[ -n ${DEBUG+x} ]]; then
    printf "${BC} ★  DEBUG${EC}: %s\n" "$@";
  fi
}

function echoerror() {
  local RC="\033[1;31m"
  local EC="\033[0m"
  printf "${RC} ✖  ERROR${EC}: %s\n" "$@" 1>&2;
}

##########
#  Main  #
##########

# Get a list of all modules in the following namespaces - 
#   * ansible.builtin
#   * ansible.netcommon
#   * ansible.posix
#   * ansible.utils
#   * ansible.windows
# ! ansible-doc --list ansible.builtin --json

# Generate snippets for each of the modules
# ! ansible-doc ansible.builtin.git --snippet
# also ! ansible-doc ansible.builtin.git --json

# Copy contents of static file to the top of the generated file
#   /.dotfiles/share/ansible/snippets/ansible-static.snippets

# Create new file with contents of static file and generated snippets
# /.dotfiles/vim/custom/snippets/ansible.snippets

main() {
  cmdline "${ARGS[@]}"
}

main
