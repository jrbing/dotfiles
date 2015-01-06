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
    printf "${RC} * ERROR${EC}: %s\n" "$@" 1>&2;
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
    if [[ "$ECHO_DEBUG" -eq "$BS_TRUE" ]]; then
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
    echo "$1"
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

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  spinner
#   DESCRIPTION:  Displays a spinner while a long running job is processing
#   NOTES:  Taken from http://fitnr.com/showing-a-bash-spinner.html
#-------------------------------------------------------------------------------
spinner() {
    local pid=$1
    local delay=0.5
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
    if [[ $? -eq 0 ]]; then
        printf "    ${GC}SUCCESS${EC}"
    else
        printf "    ${RC}FAILURE${EC}"
    fi

}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  spininfo
#   DESCRIPTION:  Displays a spinner while a long running job is processing
#-------------------------------------------------------------------------------
spininfo() {

    local message="${GC} *  INFO${EC}: $1"
    local command=$2

    printf "${message}";
    ( eval "${command}" > /dev/null 2>&1 ) &

    local pid=$!
    local delay=0.5
    local spinstr='|/-\'
    #local spinstr='← ↖ ↑ ↗ → ↘ ↓ ↙'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"

    if [[ $? -eq 0 ]]; then
        let columns=$(tput cols)-${#message}+${#GC}+${#EC}+11
        printf "%${columns}b" "${GC}[SUCCESS]${EC}"
    else
        let columns=$(tput cols)-${#message}+${#GC}+${#EC}+11
        printf "%${columns}b" "${RC}[FAILURE]${EC}"
    fi

    printf "\n"
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  bincheck
#   DESCRIPTION:  Checks for the existence of specified binaries in the PATH
#-------------------------------------------------------------------------------

bincheck() {
    for p in ${1}; do
        hash "$p" 2>&- || \
        { echoerror >&2 " Required program \"$p\" not installed."; exit 1; }
    done
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  blinker
#   DESCRIPTION:  Displays uses the blink1-tool application to indicate the
#                 status of a long running job
#-------------------------------------------------------------------------------
blinker() {
    local req_progs=(blink1-tool)
    bincheck ${req_progs[*]}

    local command=$*

    echoinfo "Executing \"${command}\""
    #( eval "${command}" > /dev/null 2>&1 ) &
    ( eval "${command}" ) &

    local pid=$!
    local delay=5
    local fade_delay=5000

    # Pulse blue until the process finishes
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        blink1-tool --blue -m $fade_delay > /dev/null 2>&1
        sleep $delay
        blink1-tool --off -m $fade_delay > /dev/null 2>&1
        sleep $delay
    done

    if [[ $? -eq 0 ]]; then
        echoinfo "\"${command}\" has completed successfully"
        blink1-tool --green> /dev/null 2>&1
    else
        echoerror "\"${command}\" has failed"
        blink1-tool --red> /dev/null 2>&1
    fi

}
