#!/usr/bin/env bash

# Use eza for ls command
alias ls="eza --long --group --header --binary --time-style=long-iso --icons"

#############
#  Aliases  #
#############

#alias todos="ack --nogroup '(TODO|FIX(ME)?):'"
#alias rpi_ip="arp -a | grep b8:27:eb | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'"
#alias java_ls='/usr/libexec/java_home -V'
#alias lt='ls -lAht && echo "------ OLDEST ------"'
#alias ltr='ls -lAhtr && echo "------ NEWEST ------"'
#alias clip="nc localhost 8377"
#alias purge-dsstore="find . -name '*.DS_Store' -type f -delete"
#alias flush-dns="sudo killall -HUP mDNSResponder"
#alias ans=ansible
#alias apb=ansible-playbook
#alias agx=ansible-galaxy
#alias anv=ansible-vault
#alias anav=ansible-navigator
#alias mvim="reattach-to-user-namespace mvim"
## alias sqlplus="DYLD_LIBRARY_PATH=/opt/oracle/client /usr/local/bin/rlwrap -iIp red -f ~/.dotfiles/sql/sqlplus_completions -H ~/.sqlplus_history -s 30000 /opt/oracle/client/sqlplus"
#alias uuid="uuidgen | tr -d '\n' | tr '[:upper:]' '[:lower:]' | pbcopy && pbpaste && echo"
#alias ytd="yt-dlp --force-overwrites"
#alias dcb="docker compose down && docker compose up -d && docker compose logs -f"

## Kubernetes
#alias kshell='kubectl run -it --rm debug --image=alpine --restart=Never -- sh'
#alias keti='kubectl exec -t -i' # Drop into an interactive terminal on a container
#if [[ $commands[kubecolor] ]]; then
  #alias kubectl=kubecolor
#fi

## Ripgrep
#if [[ $commands[rg] ]]; then
  #alias grep='rg'
#fi

## OpenCode
#if [[ $commands[opencode] ]]; then
  #alias opencode='reattach-to-user-namespace opencode'
#fi

