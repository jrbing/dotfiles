#!/usr/bin/env bash

# Base color variables
red=$(tput setaf 1)             # Red
green=$(tput setaf 2)           # Green
yellow=$(tput setaf 3)          # Yelow
blue=$(tput setaf 4)            # Blue
magenta=$(tput setaf 5)         # Magenta
cyan=$(tput setaf 6)            # Cyan

# Bold color variables
txtbld=$(tput bold)
bldred=${txtbld}$(tput setaf 1) # Red
bldblu=${txtbld}$(tput setaf 4) # Blue
bldwht=${txtbld}$(tput setaf 7) # White

# Formatting variables
txtund=$(tput sgr 0 1)          # Underline
txtrst=$(tput sgr0)             # Reset

# Print log message
log () {
  printf "${bldblu}[LOG]: ${1}${txtrst}\n"
}

# Print error message
error () {
  printf "${bldred}${1}${txtrst}\n"
}
