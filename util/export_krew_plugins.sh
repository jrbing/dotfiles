#!/usr/bin/env bash
#===============================================================================
# vim: softtabstop=2 shiftwidth=2 expandtab fenc=utf-8 spelllang=en ft=sh
#===============================================================================
#
#          FILE: export_krew_plugins.sh
#
#         USAGE: ./export_krew_plugins.sh
#
#   DESCRIPTION: Simple script to export all installed krew plugins
#
#===============================================================================

set -e          # Exit immediately on error
set -u          # Treat unset variables as an error
set -o pipefail # Prevent errors in a pipeline from being masked
IFS=$'\n\t'     # Set the internal field separator to a tab and newline

# Export list of all installed krew plugins to a file
kubectl krew list | awk '{print $1}' > ~/.dotfiles/util/krew_plugins.txt
