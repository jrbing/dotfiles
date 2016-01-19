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
    printf "${RC} ★  ERROR${EC}: %s\n" "$@" 1>&2;
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  echoinfo
#   DESCRIPTION:  Echo information to stdout.
#-------------------------------------------------------------------------------
function echoinfo() {
    printf "${GC} ★  INFO${EC}: %s\n" "$@";
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  echowarn
#   DESCRIPTION:  Echo warning informations to stdout.
#-------------------------------------------------------------------------------
function echowarn() {
    printf "${YC} ★  WARN${EC}: %s\n" "$@";
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  echodebug
#   DESCRIPTION:  Echo debug information to stdout.
#-------------------------------------------------------------------------------
function echodebug() {
    if [[ "$ECHO_DEBUG" -eq "$BS_TRUE" ]]; then
        printf "${BC} ★ DEBUG${EC}: %s\n" "$@";
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
function option_enabled () {
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
#          NAME:  bincheck
#   DESCRIPTION:  Checks for the existence of specified binaries in the PATH
#-------------------------------------------------------------------------------
function bincheck() {
    for p in ${1}; do
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


#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  [start/stop]_spinner
#   DESCRIPTION:  Displays a spinner while a long running job is processing
#   NOTES:  Modified from https://github.com/tlatsas/bash-spinner
#-------------------------------------------------------------------------------
function _spinner() {
    # $1 start/stop
    # on start: $2 display message
    # on stop : $2 process exit status
    #           $3 spinner function pid (supplied from stop_spinner)

    #local on_success="SUCCESS"
    local on_success="✓"
    #local on_fail="FAIL"
    local on_fail="✗"

    case $1 in
        start)
            local message="${GC} ★  INFO${EC}: $2"
            let column=$(tput cols)-${#message}+14 # calculate the column where spinner and status msg will be displayed

            echo -ne "${message}" # display message and position the cursor in $column column
            printf "%${column}s"

            # start spinner
            local i=1
            local sp='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
            #local spinstr='← ↖ ↑ ↗ → ↘ ↓ ↙'
            local delay=0.15

            while :
            do
                printf "\b${sp:i++%${#sp}:1}"
                sleep $delay
            done
            ;;
        stop)
            if [[ -z ${3} ]]; then
                echo "Spinner is not running.."
                exit 1
            fi

            kill "$3" > /dev/null 2>&1

            # inform the user upon success or failure
            echo -en "\b"
            if [[ $2 -eq 0 ]]; then
                echo -en "${GC}${on_success}${EC}"
            else
                echo -en "${RC}${on_fail}${EC}"
            fi
            echo -e " "
            ;;
        *)
            echo "Invalid argument, try {start/stop}"
            exit 1
            ;;
    esac
}

function start_spinner {
    tput civis                # Hide the cursor
    _spinner "start" "${1}" & # $1 : msg to display
    _sp_pid=$!                # set global spinner pid
    disown
}

function stop_spinner {
    _spinner "stop" "${1}" "$_sp_pid" # $1 : command exit status
    unset _sp_pid
    tput cnorm                        # Show the cursor
}
