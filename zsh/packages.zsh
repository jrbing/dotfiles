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
  hook-build:"ln -nfs ${ZPLUG_ROOT}/repos/sorin-ionescu/prezto ${ZDOTDIR:-$HOME}/.zprezto"

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

zplug 'pulumi/kubespy', \
  as:command, \
  from:gh-r

zplug 'davrodpin/mole', \
  as:command, \
  from:gh-r

zplug 'asciimoo/wuzz', \
  as:command, \
  from:gh-r

zplug 'trailofbits/twa', \
  as:command, \
  use:'twa'

zplug 'chubin/cheat.sh', \
  as:command, \
  use:'share/cht.sh.txt', \
  rename-to:'cht.sh'

# Be sure to install the pyyaml dependency for this
#   `pip3 install pyyaml`
zplug 'lbolla/kube-secret-editor', \
  as:command, \
  use:'(*).py', \
  rename-to:'$1'

# TODO: figure out why this fails to update
#zplug 'drwetter/testssl.sh', \
  #as:command, \
  #use:'(*).sh', \
  #rename-to:'$1'
#zplug 'darold/pgFormatter', \
  #as:command, \
  #use:'pg_format'
# akme/lsofgraph-python
# sapegin/shipit
