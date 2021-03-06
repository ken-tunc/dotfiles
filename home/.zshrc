autoload -Uz add-zsh-hook

## environment variables
export CLICOLOR=1
export GPG_TTY="$(tty)"
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"

typeset -U path
path=(
  ~/.local/bin
  ~/.local/libexec
  /usr/local/opt/python@3/libexec/bin
  /usr/local/sbin
  "$JAVA_HOME/bin"
  $path
  "$(python3 -m site --user-base)/bin"
  "$(go env GOPATH)/bin"
  "$(npm prefix -g)/bin"
  # Android sdk CLI tools
  "$ANDROID_SDK_ROOT/tools/bin"
  "$ANDROID_SDK_ROOT/platform-tools"
  "$ANDROID_SDK_ROOT/emulator"
)

fpath=(
  /usr/local/share/zsh-completions
  $fpath
  ~/.local/share/zsh/site-functions
)

## directories
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true

## history
[[ -z $HISTFILE ]] && HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt share_history

## completion
setopt always_to_end
setopt auto_menu
setopt complete_in_word
setopt correct
setopt list_packed
setopt magic_equal_subst
zmodload -i zsh/complist

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' recent-dirs-insert fallback
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:*:docker:*' option-stacking yes

autoload -Uz compinit && compinit -C

# third party tools
[[ "$commands[kubectl]" ]] && source <(kubectl completion zsh)
[[ "$commands[gh]" ]] && eval "$(gh completion --shell zsh)"

# generate completions from --help output if no other completion is defined
compdef _gnu_generic -default-

## aliases and functions
alias cp='cp -c'
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lAh'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias sudoedit='sudo -e'
alias run-help &> /dev/null && unalias run-help
autoload -Uz run-help run-help-git run-help-openssl run-help-sudo
autoload -Uz imgcat pyenv

## key bindings
autoload -Uz edit-command-line && zle -N edit-command-line
bindkey -e
bindkey \
  '^P' history-beginning-search-backward \
  '^N' history-beginning-search-forward \
  '^X^E' edit-command-line
bindkey -M menuselect \
  '^B' backward-char \
  '^F' forward-char \
  '^P' up-line-or-history\
  '^N' down-line-or-history \
  '^J' accept-and-menu-complete \
  '^?' undo \
  '^[[Z' reverse-menu-complete

if [[ "$commands[fzf]" ]]; then
  [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
  source "/usr/local/opt/fzf/shell/key-bindings.zsh"
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'

  autoload -Uz cd-submodule cd-worktree
  autoload -Uz fzf-src && zle -N fzf-src
  bindkey '\ej' fzf-src
fi

## misc
setopt no_clobber
setopt no_flow_control
autoload -Uz select-word-style && select-word-style bash

# plugins
if [[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets)
fi

if [[ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# theme
[[ "$commands[starship]" ]] && eval "$(starship init zsh)"
