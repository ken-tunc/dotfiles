autoload -Uz add-zsh-hook

# environment variables
export CLICOLOR=1

typeset -U path
path=(
  ~/.local/bin
  ~/.cargo/bin
  $path
)

fpath=(
  "$(brew --prefix)/share/zsh-completions"
  "$(brew --prefix)/share/zsh/site-functions"
  $fpath
  ~/.local/share/zsh/site-functions
)

# history
[[ -z $HISTFILE ]] && HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt share_history

# completion
setopt always_to_end
setopt auto_menu
setopt complete_in_word
setopt correct
setopt list_packed

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''

autoload -Uz compinit && compinit -u
compdef _gnu_generic -default-

# aliases
alias cp='cp -c'
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lAh'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# key bindings
autoload -Uz edit-command-line && zle -N edit-command-line
bindkey -e
bindkey \
  '^P' history-beginning-search-backward \
  '^N' history-beginning-search-forward \
  '^X^E' edit-command-line

if [[ "$commands[fzf]" ]]; then
  eval "$(fzf --zsh)"
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --select-1'

  autoload -Uz cd-worktree
  autoload -Uz fzf-src && zle -N fzf-src
  bindkey '^]' fzf-src
fi

# misc
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

[[ "$commands[direnv]" ]] && eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
