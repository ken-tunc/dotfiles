if status --is-login
  set -x COPYFILE_DISABLE 1
  set -x EDITOR vim
  set -x LANG en_US.UTF-8
  set -x LESS iMR
  set -x PAGER less

  set -x GOPATH ~/.go
end

if status --is-interactive
  set fish_greeting
  set -x CLICOLOR 1
  set -x GEM_HOME (/usr/local/bin/ruby -e 'print Gem.user_dir')
  set -x GPG_TTY (tty)
  set -x JAVA_HOME (/usr/libexec/java_home)

  set -x PATH \
    ~/.local/bin \
    /usr/local/opt/python/libexec/bin \
    $JAVA_HOME/bin \
    $PATH \
    (/usr/local/bin/python3 -m site --user-base)/bin \
    $GEM_HOME/bin \
    (/usr/local/bin/go env GOPATH)/bin

  if type -q fd
    set -x FZF_DEFAULT_COMMAND command "fd --type file --follow --hidden --no-ignore-vcs . 2> /dev/null"
    set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    set -x FZF_ALT_C_COMMAND command "fd --type directory --follow --hidden --no-ignore-vcs \$dir 2> /dev/null"
  end
end
