case $- in
  *i*) ;;
  *) return;;
esac

# environment variables
export CLICOLOR=1
export EDITOR='vim'
export LANG='en_US.UTF-8'
export LESS='iMR'
export PAGER='less'

export PATH="~/.local/bin:$PATH"

# prompt
PS1="[\u@\h \w]\$ "

# history
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

# completion
if [ -d /usr/local/etc/bash_completion.d ]; then
  for f in /usr/local/etc/bash_completion.d/*
  do
    . "$f"
  done
fi

# aliases
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lAh'
alias grep='grep --color=auto'
