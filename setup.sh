#!/bin/bash

DOTFILE_DIR="$(cd "$(dirname $0)" && pwd)"

main() {
  cd "$DOTFILE_DIR"

  git submodule update --init --remote

  setup_gpg
  setup_shell
  setup_tex
  setup_vim
  setup_misc

  install_deps
}

abort() {
  echo "$1" 1>&2
  exit 1
}

setup_gpg() {
  if [[ ! -d ~/.gnupg ]]; then
    mkdir ~/.gnupg
  fi
  chmod 700 ~/.gnupg

  chmod 700 "$DOTFILE_DIR/.gnupg"
  chmod 600 "$DOTFILE_DIR/.gnupg/gpg.conf"
  chmod 600 "$DOTFILE_DIR/.gnupg/gpg-agent.conf"

  install_symlink ".gnupg/gpg.conf"
  install_symlink ".gnupg/gpg-agent.conf"
}

setup_shell() {
  install_symlink ".bash_profile"
  install_symlink ".bashrc"
  install_symlink ".inputrc"
  install_symlink ".local/opt"
  install_symlink ".zshenv"
  install_symlink ".zshrc"
}

setup_tex() {
  if ! command -v tlmgr >/dev/null 2>&1; then
    abort "$0: tlmgr is required."
  fi

  sudo tlmgr update --self --all

  if [[ -d "$(kpsewhich -var-value=TEXMFHOME)" ]]; then
    return 0
  fi

  tlmgr init-usertree
  sudo tlmgr paper a4

  sudo tlmgr install \
    collection-langjapanese \
    latexmk
}

setup_vim() {
  # Install vim-plug
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # Override system vim
  local mvim_dir=/usr/local/bin
  local old_pwd="$(pwd)"
  cd "$mvim_dir"
  for cmd in vi vim vimdiff view vimex
  do
    if [[ -x "$mvim_dir/mvim" ]]; then
      ln -s mvim $cmd
    else
      [[ -L "$cmd" ]] && rm "$cmd"
    fi
  done
  cd "$old_pwd"

  install_symlink ".config/nvim"
  install_symlink ".gvimrc"
  install_symlink ".vim"
  install_symlink ".vimrc"
}

setup_misc() {
  install_symlink ".config/git/config"
  install_symlink ".config/git/ignore"
  install_symlink ".config/latexmk/latexmkrc"
  install_symlink ".ideavimrc"
  install_symlink ".npmrc"
  install_symlink ".screenrc"
  install_symlink ".tern-config"
  install_symlink ".tmux.conf"
  install_symlink "Library/Application Support/Code/User/locale.json"
  install_symlink "Library/Application Support/Code/User/settings.json"
  install_symlink "Library/LaunchAgents/org.gnupg.gpg-agent.plist"

  # vscode
  chmod 700 ~/Library/Application\ Support/Code
}

install_deps() {
  brew update && brew install \
    cmake \
    ctags \
    fzf \
    ghostscript \
    node \
    zsh-completions \
    zsh-syntax-highlighting

  vim +PlugUpdate +qall
}

relative_path() {
  if command -v perl >/dev/null 2>&1; then
    perl -e "use File::Spec; print File::Spec->abs2rel('$1')"
  elif command -v ruby >/dev/null 2>&1; then
    ruby -e \
      "require 'pathname'; print(Pathname.new('$1').relative_path_from(Pathname.new('$(pwd)')))"
  elif command -v python >/dev/null 2>&1; then
    python -c \
      "from __future__ import print_function; import os; print(os.path.relative_path('$1'), end='')"
  else
    abort "$0: Needs perl, ruby, or python."
  fi
}

install_symlink() {
  local old_pwd="$(pwd)"
  local dir="$(dirname ~/"$1")"
  [[ ! -d "$dir" ]] && mkdir -p "$dir"
  cd "$dir"
  ln -s "$(relative_path "$DOTFILE_DIR/$1")" .
  cd "$old_pwd"
}

main
