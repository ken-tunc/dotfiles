autoload -Uz add-zsh-hook

## environment variables
export CLICOLOR=1
export GEM_HOME="$(/usr/local/bin/ruby -e 'print Gem.user_dir')"
export GPG_TTY="$(tty)"

typeset -U path
path=(
  "$HOME/.local/bin"
  "/usr/local/opt/python/libexec/bin"
  $path
  "$(/usr/local/bin/python2 -c 'import site; print(site.getuserbase())')/bin"
  "$(/usr/local/bin/python3 -c 'import site; print(site.getuserbase())')/bin"
  "$GEM_HOME/bin"
  "$GOPATH/bin"
)
fpath=(
  "/usr/local/share/zsh-completions"
  "$HOME/.local/share/zsh/site-functions"
  $fpath
)

## prompts
setopt prompt_subst

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '%F{green}(%b)%f' '%u%c'
zstyle ':vcs_info:*' actionformats '%F{red}(%b|%a)%f' '%F{red}[%a]%f%u%c'
zstyle ':vcs_info:*' stagedstr "%F{yellow}[staged]%f"
zstyle ':vcs_info:*' unstagedstr "%B%F{red}[unstaged]%f"
zstyle ':vcs_info:*' check-for-changes true

preexec() {
  [[ "$TERM" = "screen" ]] && echo -ne "\ek$1\e\\"
}

update_prompt() {
  [[ -z "$TMUX" ]] && echo -ne "\033]0;\007"
  vcs_info
  [[ "$TERM" = "screen" ]] && echo -ne "\ek$(basename $SHELL)\e\\"

  local prompt_str="%n"
  if [[ -n "$SSH_CONNECTION" ]]; then
    prompt_str+="@%m"
  fi
  prompt_str+=": %~"
  if [[ -n "$vcs_info_msg_0_" ]]; then
    prompt_str+="$vcs_info_msg_0_%b"
  fi
  PROMPT="$prompt_str %(!.#.$) "
  RPROMPT="$vcs_info_msg_1_"
}

add-zsh-hook precmd update_prompt

## key bindings
bindkey -e
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

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
setopt auto_menu
setopt correct
setopt list_packed
setopt magic_equal_subst

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ''

autoload -Uz compinit && compinit

## directories
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

## aliases
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lAh'
alias grep='grep --color=auto'
unalias run-help
autoload -Uz run-help run-help-git run-help-sudo

## misc
setopt no_clobber
setopt no_flow_control
autoload -Uz edit-command-line

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
