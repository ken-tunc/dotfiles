autoload -Uz add-zsh-hook

## environment variables
export CLICOLOR=1
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

typeset -U path
path=(
  ~/.local/bin
  $path
  ~/Library/Application\ Support/JetBrains/Toolbox/scripts
)

fpath=(
  "$(brew --prefix)/share/zsh-completions"
  "$(brew --prefix)/share/zsh/site-functions"
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

autoload -Uz compinit && compinit -u

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
autoload -Uz qlook
[[ "$commands[gh]" ]] && eval "$(gh copilot alias -- zsh)"

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

autoload -Uz expand-alias && zle -N expand-alias
bindkey '^M' expand-alias

alias gs='git status'
alias k='kubectl'

if [[ "$commands[fzf]" ]]; then
  eval "$(fzf --zsh)"
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'

  autoload -Uz cd-submodule cd-worktree
  autoload -Uz fzf-src && zle -N fzf-src
  bindkey '^]' fzf-src
  autoload -Uz pet-select && zle -N pet-select
  stty -ixon
  bindkey '^s' pet-select
fi

## misc
setopt no_clobber
setopt no_flow_control
autoload -Uz select-word-style && select-word-style bash

# plugins
if [[ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets)
fi

if [[ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# direnv
[[ "$commands[direnv]" ]] && eval "$(direnv hook zsh)"

# theme
[[ "$commands[starship]" ]] && eval "$(starship init zsh)"
