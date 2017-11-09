export CLICOLOR=1
export EDITOR='vim'
export LANG='en_US.UTF-8'
export LESS='iMR'
export PAGER='less'

export GEM_HOME="$(/usr/local/bin/ruby -e 'print Gem.user_dir')"
export GOPATH=~/Library/Go

path="$HOME/.local/bin"
path+=":/usr/local/opt/python/libexec/bin"
path+=":$PATH"
path+=":$(/usr/local/bin/python2 -c 'import site; print(site.getuserbase())')/bin"
path+=":$(/usr/local/bin/python3 -c 'import site; print(site.getuserbase())')/bin"
path+=":$GEM_HOME/bin"
path+=":$GOPATH/bin"
export PATH="$path"
unset path

[[ -f ~/.bashrc ]] && . ~/.bashrc
