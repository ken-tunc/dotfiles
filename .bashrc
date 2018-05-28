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
path+=":$JAVA_HOME/bin"
path+=":$(npm prefix -g)/bin"
path+=":$PATH"
path+=":$(python3 -c 'import site; print(site.getuserbase())')/bin"
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
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lAh'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias qlook='qlmanage -p'
alias sudoedit='sudo -e'

# prompt
PS1='\u'
if [[ -n "$SSH_CONNECTION" ]]; then
  PS1+='@\h'
fi
PS1+=': \w \$ '

# misc
shopt -s checkjobs 2>/dev/null
shopt -s checkwinsize
shopt -s globstar 2>/dev/null
