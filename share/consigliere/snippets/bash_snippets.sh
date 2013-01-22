#!/usr/bin/env bash

############
# One-liners
############

# Unrar all files in a directory
for f in *.rar; do unrar e "$f"; done

# Change file extension for all files in a directory
for f in *.md; do mv $f `basename $f .md`.markdown; done;

####################
# Prompt to continue
####################

while true; do
  read -p "Do you want to continue (Y/N)? " answer
  case $answer in
    [Yy]* ) echo "YES"; break;;
    [Nn]* ) echo "Exiting ......" && sleep 2 && exit 0; break;;
    * ) echo "Please answer yes or no.";;
  esac
done

######################
# OS Specific Settings
######################

case $(uname) in
  (Darwin)
    # OSX Specific
  ;;
  (Linux)
    # Linux Specific
  ;;
  (SunOS)
    # Solaris Specific
  ;;
esac

##########################################
# Check to see if a script was run as root
##########################################

if [[ $UID -ne 0 ]]; then
  echo "$0 must be run as root"
  exit 1
fi


##################
# Looping Examples
##################

# define file array
files=(/etc/*.conf)
 
# find total number of files in an array
echo "Total files in array : ${#files[*]}"
total=${#files[*]}

# Print 1st file name
echo "First filename: ${files[0]}"
echo "Second filename: ${files[1]}"
echo "Third filename: ${files[1]}"

# total - 1 = last item (subscript) in an array 
echo "Last filename: ${files[$(( $total-1 ))]}"
 
# Use for loop iterate through an array
# $f stores current value 
echo
echo "****************"
echo "*** For Loop ***"
echo "****************"
for f in "${files[@]}"
do
  echo -n "$f "
done
 
# Use c style for loop
# get total subscripts in an array
echo
echo
echo "**************************"
echo "*** C Style For Loop ****"
echo "**************************"
echo
total=${#files[*]}
for (( i=0; i<=$(( $total -1 )); i++ ))
do
    echo -n "${files[$i]} "
done

#########
# Spinner
#########
function _spinner() {

  # $1 start/stop
  # on start: $2 display message
  # on stop : $2 process exit status
  #           $3 spinner function pid (supplied from stop_spinner)

  local on_success="DONE"
  local on_fail="FAIL"
  local white="\e[1;37m"
  local green="\e[1;32m"
  local red="\e[1;31m"
  local nc="\e[0m"

  case $1 in

    (start)
      # Calculate the column where spinner and status msg will be displayed
      let column=$(tput cols)-${#2}-8
      # Display message and position the cursor in $column column
      echo -ne ${2}
      printf "%${column}s"

      # Start spinner
      i=1
      sp='\|/-'
      delay=0.15

      while :
      do
        printf "\b${sp:i++%${#sp}:1}"
        sleep $delay
      done
      ;;

    (stop)
      if [[ -z ${3} ]]; then
        printf "Spinner is not running.."
        exit 1
      fi

      kill $3 > /dev/null 2>&1

      # Inform the user upon success or failure
      echo -en "\b["
      if [[ $2 -eq 0 ]]; then
        echo -en "${green}${on_success}${nc}"
      else
        echo -en "${red}${on_fail}${nc}"
      fi
      echo -e "]"
      ;;

    (*)
      printf "Invalid argument, try {start/stop}\n"
      exit 1
      ;;

  esac
}

function start_spinner {
  # $1 : msg to display
  _spinner "start" "${1}" &
  # set global spinner pid
  _sp_pid=$!
  disown
}

function stop_spinner {
  # $1 : command exit status
  _spinner "stop" $1 $_sp_pid
  unset _sp_pid
}

