#
# zplug packages
#

zplug "clvv/fasd", \
  as:command, \
  use:'fasd'

zplug "sorin-ionescu/prezto", \
  as:plugin, \
  use:init.zsh, \
  hook-build:"ln -s ${ZPLUG_ROOT}/repos/sorin-ionescu/prezto ${ZDOTDIR:-$HOME}/.zprezto"

zplug "belak/prezto-contrib", \
  as:plugin

zplug "asdf-vm/asdf", \
  as:plugin, \
  use:'asdf.sh'

zplug "Tarrasch/zsh-bd", \
  as:plugin

zplug "rimraf/k", \
  as:plugin

zplug "b4b4r07/httpstat", \
  as:command, \
  use:'(*).sh', \
  rename-to:'$1'

zplug "genuinetools/reg", \
  from:gh-r, \
  as:command

zplug "genuinetools/audit", \
  from:gh-r, \
  as:command

zplug "genuinetools/pepper", \
  from:gh-r, \
  as:command

#akme/lsofgraph-python
# sapegin/shipit
