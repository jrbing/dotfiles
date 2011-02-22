
# -----------------------------------------------
# Set up the Environment
# -----------------------------------------------

TERM=screen
EDITOR=vim
PAGER=less
RSYNC_RSH=/usr/bin/ssh
FIGNORE='.o:.out:~'
DISPLAY=:0.0
LS_COLORS='no=00:fi=00:di=00;36:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.bz2=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.sit=01;31:*.hqx=01;31:*.jpg=01;35:*.png=01;35:*.gif=01;35:*.bmp=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mpg=01;35:*.avi=01;35:*.mov=01;35:*.app=01;33:*.c=00;33:*.php=00;33:*.pl=00;33:*.cgi=00;33:'
COLORTERM=yes
PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin
HISTFILE=~/.zshhistory
HISTSIZE=3000
SAVEHIST=3000

export TERM EDITOR PAGER RSYNC_RSH CVSROOT FIGNORE DISPLAY LS_COLORS NNTPSERVER COLORTERM PATH HISTFILE HISTSIZE SAVEHIST

# -----------------------------------------------
# Set up the prompt
# -----------------------------------------------

# root prompt
[ $UID = 0 ] && export PROMPT=$'%{\e[0;31m%}[%{\e[0m%}%n%{\e[0;31m%}@%{\e[0m%}hostname%{\e[0;31m%}:%{\e[0m%}%~%{\e[0;31m%}]%{\e[0m%}%# '
# normal user prompt
[ $UID != 0 ] && export PROMPT=$'%{\e[0;36m%}[%{\e[0m%}%n%{\e[0;36m%}@%{\e[0m%}hostname%{\e[0;36m%}:%{\e[0m%}%~%{\e[0;36m%}]%{\e[0m%}%# '
#export RPROMPT=$"%{\e[0;33m%}[%T]%{\e[0m%}"

# -----------------------------------------------
# Load zsh modules
# -----------------------------------------------

# compinit initializes various advanced completions for zsh
autoload -U compinit && compinit
# zmv is a batch file rename tool; e.g. zmv '(*).text' '$1.txt'
autoload zmv

# -----------------------------------------------
# Set up zsh autocompletions
# -----------------------------------------------

# case-insensitive tab completion for filenames (useful on Mac OS X)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# General completion technique
zstyle ':completion:*' completer _complete _correct _approximate _prefix
zstyle ':completion:*' completer _complete _prefix
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:predict:*' completer _complete

# Completion caching
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

# Expand partial paths
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'

# Don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

# Separate matches into groups
zstyle ':completion:*:matches' group 'yes'

# Describe each match group.
zstyle ':completion:*:descriptions' format "%B---- %d%b"

# Messages/warnings format
zstyle ':completion:*:messages' format '%B%U---- %d%u%b' 
zstyle ':completion:*:warnings' format '%B%U---- no match for: %d%u%b'
 
# Describe options in full
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# -----------------------------------------------
# Set up completion for hostnames
# -----------------------------------------------

if [[ "$ZSH_VERSION_TYPE" == 'new' ]]; then
  : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}}
else
  # Older versions don't like the above cruft
  _etc_hosts=()
fi

hosts=(
    "$_etc_hosts[@]"

    localhost
    #Add favourite hosts here, and zsh will autocomplete them
)

zstyle ':completion:*' hosts $hosts

my_accounts=(
    root@localhost
    #Add ssh hosts here, and zsh will autocomplete them
)

zstyle ':completion:*:my-accounts' users-hosts $my_accounts

# -----------------------------------------------
# Set zsh options
# -----------------------------------------------

setopt \
    no_beep \
    correct \
    auto_list \
    complete_in_word \
    auto_pushd \
    complete_aliases \
    extended_glob \
    zle

# -----------------------------------------------
# Shell Aliases
# -----------------------------------------------

## Command Aliases
alias x=exit
alias c=clear
alias s=screen
alias r='screen -R'
alias vi='vim'
#alias ls='ls --color=auto -F'
#alias l='ls -lAF --color=auto'
alias sls='screen -ls'
alias zrc='vim /etc/zshrc'
alias cdw='cd ~/Sites/web'
alias e='smartextract'
alias o='open'

## Pipe Aliases (Global)
alias -g L='|less'
alias -g G='|grep'
alias -g T='|tail'
alias -g H='|head'
alias -g W='|wc -l'
alias -g S='|sort'

## Shell Aliases

# UPenn
alias srvr='ssh user@server.example.com'

## Special Root Aliases
[ $UID = 0 ] && \
    alias m='make' && \
    alias mi='make install' && \
    alias rm='rm -i' && \
    alias mv='mv -i' && \
    alias cp='cp -i'

# -----------------------------------------------
#  User-defined Functions
# -----------------------------------------------

# Usage: smartextract <file>
# Description: extracts archived files / mounts disk images
# Note: .dmg/hdiutil is Mac OS X-specific.
smartextract () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar -jxvf $1        ;;
            *.tar.gz)   tar -zxvf $1        ;;
            *.bz2)      bunzip2 $1          ;;
            *.dmg)      hdiutil mount $1    ;;
            *.gz)       gunzip $1           ;;
            *.tar)      tar -xvf $1         ;;
            *.tbz2)     tar -jxvf $1        ;;
            *.tgz)      tar -zxvf $1        ;;
            *.zip)      unzip $1            ;;
            *.Z)        uncompress $1       ;;
            *)          echo "'$1' cannot be extracted/mounted via smartextract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

autoload -U promptinit
promptinit
prompt adam2

export CLICOLOR=1
export LSCOLORS=CxFxExDxBxegedabagacad

# -----------------------------------------------
#  END
# -----------------------------------------------
