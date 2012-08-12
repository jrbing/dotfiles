#!/usr/bin/env bash

prompt_command () {
  local DEFAULT="\[\033[0;39m\]"
  export PS1="${BRIGHT_BLUE}➜ ${DEFAULT} \W  "
}

PROMPT_COMMAND=prompt_command;
