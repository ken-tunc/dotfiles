set --export COPYFILE_DISABLE 1
set --export EDITOR vim
set --export LANG en_US.UTF-8
set --export LESS iMR
set --export PAGER less

set --export GOPATH ~/.go

if status --is-interactive
  set fish_greeting
  set --export CLICOLOR 1
  set --export GEM_HOME (/usr/local/bin/ruby -e 'print Gem.user_dir')
  set --export GPG_TTY (tty)

  set PATH \
    ~/.local/bin \
    /usr/local/opt/python/libexec/bin \
    /usr/local/sbin \
    $PATH \
    (/usr/local/bin/python3 -m site --user-base)/bin \
    $GEM_HOME/bin \
    (/usr/local/bin/go env GOPATH)/bin
end
