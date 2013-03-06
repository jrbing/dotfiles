if [[ ! -o interactive ]]; then
    return
fi

compctl -K _valet valet

_valet() {
  local word words completions
  read -cA words
  word="${words[2]}"

  if [ "${#words}" -eq 2 ]; then
    completions="$(valet commands)"
  else
    completions="$(valet completions "${word}")"
  fi

  reply=("${(ps:\n:)completions}")
}
