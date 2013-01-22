#!/usr/bin/env bash

# Set the script to exit immediately on error
set -e

usage(){
cat <<'EOT'
Call this script with...
EOT
exit 0;
}

# Exit if there are no arguments
[ $# -eq 0 ] && usage
set -- `getopt -n$0 -u -a --longoptions "help dogs: cats:" "hd:c:" "$@"`

# $# is the number of arguments
while [ $# -gt 0 ]
do
  case "$1" in
  -d|--dogs) dogs="$2"; shift;;
  -c|--cats) cats="$2"; shift;;
  -h| --help) usage;;
  --) shift;break;;
  *) break;;
  esac
  shift
done

cleanup_before_exit () {
  # this code is run before exit
  echo -e "Running cleanup code and exiting"
}
# trap catches the exit signal and runs the specified function
trap cleanup_before_exit EXIT

# OK now do stuff
echo "$cats and $dogs living together, mass hysteria!"
