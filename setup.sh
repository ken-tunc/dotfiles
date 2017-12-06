#!/bin/bash

DOTFILE_DIR="$(cd "$(dirname $0)" && pwd)"

main() {
  cd "$DOTFILE_DIR"

  # Should be called first.
  setup_gpg

  install_symlink ".bash_profile"
  install_symlink ".bashrc"
  install_symlink ".config/git/config"
  install_symlink ".config/git/ignore"
  install_symlink ".config/latexmk/latexmkrc"
  install_symlink ".config/nvim"
  install_symlink ".gnupg/gpg.conf"
  install_symlink ".gnupg/gpg-agent.conf"
  install_symlink ".gvimrc"
  install_symlink ".inputrc"
  install_symlink ".npmrc"
  install_symlink ".screenrc"
  install_symlink ".tern-config"
  install_symlink ".tmux.conf"
  install_symlink ".vim"
  install_symlink ".vimrc"
  install_symlink "Library/Application Support/pip/pip.conf"
  install_symlink "Library/Application Support/Code/User/locale.json"
  install_symlink "Library/Application Support/Code/User/settings.json"
  install_symlink "Library/LaunchAgents/org.gnupg.gpg-agent.plist"

  setup_vim

  # vscode
  chmod 700 ~/Library/Application\ Support/Code
}

setup_gpg() {
  if [[ ! -d ~/.gnupg ]]; then
    mkdir ~/.gnupg
    chmod 700 ~/.gnupg
  fi

  chmod 700 "$DOTFILE_DIR/.gnupg"
  chmod 600 "$DOTFILE_DIR/.gnupg/gpg.conf"
  chmod 600 "$DOTFILE_DIR/.gnupg/gpg-agent.conf"
}

relative_path() {
  if [[ -x /usr/bin/perl ]]; then
    /usr/bin/perl -e "use File::Spec; print File::Spec->abs2rel('$1')"
  elif [[ -x /usr/bin/ruby ]]; then
    /usr/bin/ruby -e \
      "require 'pathname'; print(Pathname.new('$1').relative_path_from(Pathname.new('$(pwd)')))"
  elif [[ -x /usr/bin/python ]]; then
    /usr/bin/python -c \
      "from __future__ import print_function; import os; print(os.path.relative_path('$1'), end='')"
  else
    echo "$0: Needs perl, ruby, or python." 1>&2
    exit 1
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

setup_vim() {
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
}

main
