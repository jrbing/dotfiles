#!/usr/bin/env bash
#===============================================================================
# vim: softtabstop=4 shiftwidth=4 expandtab fenc=utf-8 spell spelllang=en
#===============================================================================
#
#          FILE: bash-functions.sh
#
#   DESCRIPTION: Generic bash functions to be included in other scripts
#
#===============================================================================

set -o nounset                              # Treat unset variables as an error

function defined {
    [[ ${!1-X} == ${!1-Y} ]]
}

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
    printf "${RC} * ERROR${EC}: $@\n" 1>&2;
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  echoinfo
#   DESCRIPTION:  Echo information to stdout.
#-------------------------------------------------------------------------------
function echoinfo() {
    printf "${GC} *  INFO${EC}: %s\n" "$@";
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  echowarn
#   DESCRIPTION:  Echo warning informations to stdout.
#-------------------------------------------------------------------------------
function echowarn() {
    printf "${YC} *  WARN${EC}: %s\n" "$@";
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  echodebug
#   DESCRIPTION:  Echo debug information to stdout.
#-------------------------------------------------------------------------------
function echodebug() {
    if [ $ECHO_DEBUG -eq $BS_TRUE ]; then
        printf "${BC} * DEBUG${EC}: %s\n" "$@";
    fi
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  file_exists
#   DESCRIPTION:  Returns 0 if a (regular) file exists
#-------------------------------------------------------------------------------
function file_exists {
    if [[ -f "$1" ]]; then
        return 0
    fi
    return 1
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  tolower
#   DESCRIPTION:  Returns lowercase string
#-------------------------------------------------------------------------------
function tolower {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  toupper
#   DESCRIPTION:  Returns uppercase string
#-------------------------------------------------------------------------------
function toupper {
    echo "$1" | tr '[:lower:]' '[:upper:]'
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  trim
#   DESCRIPTION:  Only returns the first part of a string, delimited by tabs or spaces
#-------------------------------------------------------------------------------
function trim {
    echo $1
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  option_enabled
#   DESCRIPTION:  Checks if a variable is set to "y" or "yes"
#-------------------------------------------------------------------------------
option_enabled () {

    VAR="$1"
    VAR_VALUE=$(eval echo \$$VAR)
    if [[ "$VAR_VALUE" == "y" ]] || [[ "$VAR_VALUE" == "yes" ]]
    then
        return 0
    else
        return 1
    fi
}
