set --export COPYFILE_DISABLE 1
set --export EDITOR vim
set --export LANG en_US.UTF-8
set --export LESS iMR
set --export PAGER less

set --export ANDROID_SDK_ROOT ~/Library/Android/sdk
set --export GOPATH ~/.go

if status --is-interactive
  set fish_greeting
  set --export GPG_TTY (tty)
  set --export JAVA_HOME (/usr/libexec/java_home -v 1.8)

  set PATH \
    ~/.local/bin \
    ~/.local/libexec \
    /usr/local/opt/python@3/libexec/bin \
    /usr/local/sbin \
    $JAVA_HOME/bin \
    $PATH \
    (/usr/local/bin/python3 -m site --user-base)/bin \
    (/usr/local/bin/go env GOPATH)/bin \
    (npm prefix -g)/bin \
    $ANDROID_SDK_ROOT/tools/bin \
    $ANDROID_SDK_ROOT/platform-tools \
    $ANDROID_SDK_ROOT/emulator
end
