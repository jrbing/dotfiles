#!/usr/bin/env bash
#===============================================================================
# vim: softtabstop=4 shiftwidth=4 expandtab fenc=utf-8
#===============================================================================
#
#          FILE: bash-functions.sh
#
#   DESCRIPTION: Generic bash functions to be included in other scripts
#
#===============================================================================

set -o nounset  # Treat unset variables as an error

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  __detect_color_support
#   DESCRIPTION:  Try to detect color support.
#-------------------------------------------------------------------------------
COLORS=${BS_COLORS:-$(tput colors 2>/dev/null || echo 0)}
__detect_color_support() {
    if [ $? -eq 0 ] && [ "$COLORS" -gt 2 ]; then
        RC="\033[1;31m"
        GC="\033[1;32m"
        BC="\033[1;34m"
        YC="\033[1;33m"
        EC="\033[0m"
    else
        RC=""
        GC=""
        BC=""
        YC=""
        EC=""
    fi
}
__detect_color_support

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  echoerr
#   DESCRIPTION:  Echo errors to stderr.
#-------------------------------------------------------------------------------
function echoerror() {
    printf "${RC} ✖  ERROR${EC}: %s\n" "$@" 1>&2;
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  echoinfo
#   DESCRIPTION:  Echo information to stdout.
#-------------------------------------------------------------------------------
function echoinfo() {
    printf "${GC} ☆  INFO${EC}: %s\n" "$@";
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  echowarn
#   DESCRIPTION:  Echo warning information to stdout.
#-------------------------------------------------------------------------------
function echowarn() {
    printf "${YC} ★  WARN${EC}: %s\n" "$@";
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  echodebug
#   DESCRIPTION:  Echo debug information to stdout.
#-------------------------------------------------------------------------------
function echodebug() {
    if [[ -n ${DEBUG+x} ]]; then
        printf "${BC} ★  DEBUG${EC}: %s\n" "$@";
    fi
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  bincheck
#   DESCRIPTION:  Checks for the existence of specified binaries in the PATH
#-------------------------------------------------------------------------------
function bincheck() {
    for p in ${1}; do
        echodebug "Checking for $p"
        hash "$p" 2>&- || \
        { echoerror >&2 " Required program \"$p\" not installed."; exit 1; }
    done
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  pause
#   DESCRIPTION:  Pauses execution of the script
#-------------------------------------------------------------------------------
function pause() {
    printf "${BC} ★  PAUSE${EC}: ";
    read -p "$*"
}

