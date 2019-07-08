#!/usr/bin/env bash
#
# bootstrap installs things.
#
# Credit to https://github.com/holman/dotfiles


DOTFILES_ROOT="$(pwd -P)"
DOTFILES_DEST="$HOME/.dotfiles"
DOTFILES_SYMS="$DOTFILES_ROOT/dots"

set -e

echo ''

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

setup_gitconfig () {
  LOCALGIT=$HOME/.gitconfig.local
  if ! [ -f "$LOCALGIT" ]
  then
    info 'setup gitconfig'

    git_credential='cache'
    if [ "$(uname -s)" == "Darwin" ]
    then
      git_credential='osxkeychain'
    fi

    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail

    echo "[user]" > $LOCALGIT
    echo "  name=$git_authorname" >> $LOCALGIT
    echo "  email=$git_authoremail" >> $LOCALGIT
    echo "[credential]" >> $LOCALGIT
    echo "  helper=$git_credential" >> $LOCALGIT

    success 'gitconfig'
  fi
}

link_file () {
  local src=$1 dst=$2

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then
      if [ "$(readlink $dst)" == "$src" ]
      then
        # if the link we're trying to make exists, skip
        success "SKIPPED. Link to $src already exists"
        return 0;
      else
        user "Target exists: $dst ([s]kip, [o]verwrite)?"
        read -n 1 action

        case "$action" in
          o )
            rm -rf "$dst"
            success "removed $dst"
            ;;
          s )
            success "skipped $src"
            return 0;
            ;;
          * )
            ;;
        esac
      fi
  fi
  ln -s "$src" "$dst"
  success "linked $src to $dst"
}

install_dotfiles () {
  info 'installing dotfiles'

  local overwrite_all=false backup_all=false skip_all=false

  for src in $(find -H "$DOTFILES_SYMS" -type f -not -path '*.git*')
  do
    dst="$HOME/.$(basename ".${src}")"
    link_file "$src" "$dst"
  done
}

setup_gitconfig
install_dotfiles

# symlink this repo to home folder for
# constitent access for zshrc
link_file $DOTFILES_ROOT $DOTFILES_DEST

