# environment variables
export CLICOLOR=1
export EDITOR='vim'
export LANG='en_US.UTF-8'
export LESS='iMR'
export PAGER='less'

export GEM_HOME="$(/usr/local/bin/ruby -e 'print Gem.user_dir')"
export GOPATH=~/Library/Go

PATH="$HOME/.local/bin:$PATH"
PATH+=":/usr/local/opt/python/libexec/bin"
PATH+=":$(/usr/local/bin/python2 -c 'import site; print(site.getuserbase())')/bin"
PATH+=":$(/usr/local/bin/python3 -c 'import site; print(site.getuserbase())')/bin"
PATH+=":$GEM_HOME/bin"
PATH+=":$GOPATH/bin"
export PATH

# history
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

# completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# aliases
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lAh'
alias grep='grep --color=auto'

# prompt
host=""
vcs_info=""
[[ -n $SSH_CONNECTION ]] && host="@\h"
if [[ -n "$(type -t __git_ps1)" ]]; then
  GIT_PS1_SHOWDIRTYSTATE=1
  vcs_info='$(__git_ps1 " (%s)")'
fi
PS1='\u'"$host"': \w\[\e[32m\]'"$vcs_info"'\[\e[0m\] \$ '
unset host vcs_info
