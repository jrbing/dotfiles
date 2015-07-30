#!/usr/bin/env bash
#===============================================================================
# vim: softtabstop=2 shiftwidth=2 expandtab fenc=utf-8 spelllang=en ft=sh
#===============================================================================
#
#          FILE: menu.sh
#
#   DESCRIPTION: Displays a list of sql statements within $SQLPATH when invoked
#                from sqlplus
#
#===============================================================================

set -e          # Exit immediately on error
set -u          # Treat unset variables as an error
set -o pipefail # Prevent errors in a pipeline from being masked
IFS=$'\n\t'     # Set the internal field separator to a tab and newline
shopt -s nullglob

readonly MENUDIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)
readonly SQLDIR=$MENUDIR/oracle
readonly CURDIR=$(pwd)
menu_scripts=()

for script in "${SQLDIR}"/*.sql; do
  if ! [[ $(basename "$script" ) == "menu.sql" ]] && ! [[ $(basename "$script" ) == "login.sql" ]] ; then
    menu_scripts+=("$script")
  fi
done

function usage() {
  sed -n "s/^-- Usage: \(.*\)/\1/p" "$1"
}

function summary() {
  sed -n "s/^-- Summary: \(.*\)/\1/p" "$1"
}

function truncate() {
  local max_length="$1"
  local string="$2"

  if [ "${#string}" -gt "$max_length" ]; then
    local length=$(( $max_length - 3 ))
    echo "${string:0:$length}..."
  else
    echo "$string"
  fi
}

function print_summaries_and_usage() {
  local scripts=()
  local summaries=()
  local longest_scriptname=0
  local scriptpath

  for scriptpath in "${menu_scripts[@]}"; do
    local scriptname=$(basename "$scriptpath")
    local scriptname="${scriptname%.*}"
    local usage="$(usage "$scriptpath")"
    local summary="$(summary "$scriptpath")"

    if [[ -n "$usage" ]]; then
      scripts["${#scripts[@]}"]="$scriptname"
      summaries["${#summaries[@]}"]="$summary"

      if [ "${#scriptname}" -gt "$longest_scriptname" ]; then
        longest_scriptname="${#scriptname}"
      fi
    fi
  done

  local index
  local columns="$(tput cols)"
  local summary_length=$(( $columns - $longest_scriptname - 5 ))

  printf "\n"
  for (( index=0; index < ${#scripts[@]}; index++ )); do
    printf "   %-${longest_scriptname}s  %s\n" "${scripts[$index]}" \
      "$(truncate "$summary_length" "${summaries[$index]}")"
  done
}

print_summaries_and_usage
