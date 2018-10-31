autoload -Uz add-zsh-hook

## environment variables
export CLICOLOR=1
export GEM_HOME="$(/usr/local/bin/ruby -e 'print Gem.user_dir')"
export GPG_TTY="$(tty)"

typeset -U path
path=(
  ~/.local/bin
  /usr/local/opt/python/libexec/bin
  $path
  "$(/usr/local/bin/python3 -m site --user-base)/bin"
  "$GEM_HOME/bin"
  "$(/usr/local/bin/go env GOPATH)/bin"
)
fpath=(
  /usr/local/share/zsh-completions
  ~/.local/share/zsh/site-functions
  $fpath
)

## directories
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ":chpwd:*" recent-dirs-max 500
zstyle ":chpwd:*" recent-dirs-default true

## prompts
setopt prompt_subst

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '%F{green}(%b)%f%u%c'
zstyle ':vcs_info:*' actionformats '%F{red}(%b|%a)%f%u%c' '%F{red}[%a]%f%u%c'
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}[staged]%f"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}[unstaged]%f"
zstyle ':vcs_info:git:*' check-for-changes true

update_prompt() {
  local prompt_str="%n"
  if [[ -n "$SSH_CONNECTION" ]]; then
    prompt_str+="@%m"
  fi
  prompt_str+=": %F{blue}%~%f"
  PROMPT="%B$prompt_str%b %(!.#.$) "

  vcs_info
  RPROMPT="%B$vcs_info_msg_0_%b"

  # reset terminal title
  [[ -z "$TMUX" ]] && print -Pn "\e]0;\a"
}

add-zsh-hook precmd update_prompt

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

# python cli tools
if command -v pip > /dev/null 2>&1; then
  eval "$(pip completion --zsh)"
fi

if command -v pipenv > /dev/null 2>&1; then
  eval "$(pipenv --completion | sed -e 's/compinit$/compinit -C/')"
fi

## aliases and functions
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lAh'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias qlook='qlmanage -p'
alias sudoedit='sudo -e'
alias run-help > /dev/null 2>&1 && unalias run-help
autoload -Uz run-help run-help-git run-help-sudo run-help-openssl

## key bindings
autoload -Uz edit-command-line && zle -N edit-command-line
bindkey -e
bindkey \
  "^P" history-beginning-search-backward \
  "^N" history-beginning-search-forward \
  '^X^E' edit-command-line
bindkey -M menuselect \
  '^B' backward-char \
  '^F' forward-char \
  '^P' up-line-or-history\
  '^N' down-line-or-history \
  '^J' accept-and-menu-complete \
  '^?' undo \
  '^[[Z' reverse-menu-complete

if command -v fzf > /dev/null 2>&1; then
  source ~/.local/opt/fzf.zsh/init.zsh
  export FZF_DEFAULT_OPTS='--height 40%'
  bindkey \
    '^I' fzf-completion \
    '^[j' fzf-cd-widget \
    '^X/' fzf-file-widget \
    '^X^R' fzf-history-widget
fi

## misc
setopt no_clobber
setopt no_flow_control
autoload -Uz select-word-style && select-word-style bash
autoload -Uz url-quote-magic && zle -N self-insert url-quote-magic
autoload -Uz bracketed-paste-magic && zle -N bracketed-paste bracketed-paste-magic
autoload -Uz zrecompile && zrecompile -q -p -R ~/.zshrc -- -M ~/.zcompdump

# Apple Terminal
if [[ "$TERM_PROGRAM" = "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]]; then
  update_terminalapp_cwd() {
    local URL_PATH=''
    {
      local i ch hexch LC_CTYPE=C
      for ((i = 1; i <= ${#PWD}; ++i)); do
        ch="$PWD[i]"
        if [[ "$ch" =~ [/._~A-Za-z0-9-] ]]; then
          URL_PATH+="$ch"
        else
          hexch=$(printf "%02X" "'$ch")
          URL_PATH+="%$hexch"
        fi
      done
    }

    local PWD_URL="file://$HOST$URL_PATH"
    printf '\e]7;%s\a' "$PWD_URL"
  }

  add-zsh-hook chpwd update_terminalapp_cwd
  update_terminalapp_cwd
fi

# plugins
if [[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets)
fi
