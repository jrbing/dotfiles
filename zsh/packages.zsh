#
# zplug packages
#

zplug 'clvv/fasd', \
  depth:10, \
  as:command, \
  use:'fasd'

zplug 'sorin-ionescu/prezto', \
  depth:10, \
  as:plugin, \
  use:init.zsh, \
  hook-build:"ln -s ${ZPLUG_ROOT}/repos/sorin-ionescu/prezto ${ZDOTDIR:-$HOME}/.zprezto"

zplug 'belak/prezto-contrib', \
  depth:10, \
  as:plugin

zplug 'asdf-vm/asdf', \
  depth:10, \
  as:plugin, \
  use:'asdf.sh'

zplug 'Tarrasch/zsh-bd', \
  depth:10, \
  as:plugin

zplug 'rimraf/k', \
  depth:10, \
  as:plugin

zplug 'b4b4r07/httpstat', \
  as:command, \
  use:'(*).sh', \
  rename-to:'$1'

zplug 'genuinetools/reg', \
  as:command, \
  from:gh-r

zplug 'genuinetools/audit', \
  as:command, \
  from:gh-r

zplug 'genuinetools/pepper', \
  as:command, \
  from:gh-r

zplug 'drwetter/testssl.sh', \
  as:command, \
  use:'testssl.sh', \
  rename-to:'testssl'

# Be sure to install the pyyaml dependency for this
#   `pip3 install pyyaml`
zplug "lbolla/kube-secret-editor", \
  as:command, \
  use:'(*).py', \
  rename-to:'$1'

# akme/lsofgraph-python
# sapegin/shipit
