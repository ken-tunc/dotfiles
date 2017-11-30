# environment variables
export CLICOLOR=1
export GEM_HOME="$(/usr/local/bin/ruby -e 'print Gem.user_dir')"
export GPG_TTY="$(tty)"

path="$HOME/.local/bin"
path+=":/usr/local/opt/python/libexec/bin"
path+=":$PATH"
path+=":$(/usr/local/bin/python2 -c 'import site; print(site.getuserbase())')/bin"
path+=":$(/usr/local/bin/python3 -c 'import site; print(site.getuserbase())')/bin"
path+=":$GEM_HOME/bin"
path+=":$GOPATH/bin"
export PATH="$path"
unset path

case $- in
  *i*) ;;
  *) return;;
esac

# history
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

# completion
[[ -f /usr/local/etc/bash_completion ]] && . /usr/local/etc/bash_completion

# aliases
alias grep='grep --color=auto'
alias la='ls -A'
alias ll='ls -lh'

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

# misc
shopt | grep -q checkjobs && shopt -s checkjobs
shopt | grep -q checkwinsize && shopt -s checkwinsize
shopt | grep -q globstar && shopt -s globstar
