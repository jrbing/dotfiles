# Function to search for running processes
any() {
    emulate -L zsh
    unsetopt KSH_ARRAYS
    if [[ -z "$1" ]] ; then
        echo "any - grep for process(es) by keyword" >&2
        echo "Usage: any " >&2 ; return 1
    else
        ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
    fi
}

update_display() {
  good_display=$(netstat -an | /bin/grep 0\ [0-9,:,.]*:60..\  | awk '{print $4}' | tail -n 1)
  good_display=${good_display: -2}
  export DISPLAY=${HOSTNAME}:${good_display}.0
}
