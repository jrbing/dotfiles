if [[ ! -o interactive ]]; then
    return
fi

compctl -K _consigliere consigliere

_consigliere() {
  local word words completions
  read -cA words
  word="${words[2]}"

  if [ "${#words}" -eq 2 ]; then
    completions="$(consigliere commands)"
  else
    completions="$(consigliere completions "${word}")"
  fi

  reply=("${(ps:\n:)completions}")
}
