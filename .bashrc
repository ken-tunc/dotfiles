case $- in
  *i*) ;;
  *) return;;
esac

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
PS1='\u'
if [[ -n "$SSH_CONNECTION" ]]; then
  PS1+='@\h'
fi
PS1+=': \w'
if [[ -n "$(type -t __git_ps1)" ]]; then
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWSTASHSTATE=1
  PS1+='\[\e[32m\]$(__git_ps1 " (%s)")\[\e[0m\]'
fi
PS1+=' \$ '

# misc
shopt -s checkjobs
shopt -s checkwinsize
shopt -s globstar
