#!/usr/bin/env bash
#===============================================================================
# vim: softtabstop=2 shiftwidth=2 expandtab fenc=utf-8 spelllang=en ft=sh
#===============================================================================
#
#          FILE: import_krew_plugins.sh
#
#         USAGE: ./import_krew_plugins.sh
#
#   DESCRIPTION: Simple script to import krew plugins from a text file
#
#===============================================================================

set -e          # Exit immediately on error
set -u          # Treat unset variables as an error
set -o pipefail # Prevent errors in a pipeline from being masked
IFS=$'\n\t'     # Set the internal field separator to a tab and newline

# Update krew index and upgrade all installed plugins
kubectl krew update && kubectl krew upgrade

# Install krew plugins from a file
while read -r plugin ; do kubectl krew install "${plugin}" ; done < ~/.dotfiles/util/krew_plugins.txt
