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
