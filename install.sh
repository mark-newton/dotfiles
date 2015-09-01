#!/usr/bin/env bash
DOTFILES="$HOME/.dotfiles"
BACKUP_DIR="$DOTFILES/backups"
BIN_DIR="$HOME/bin"
GREEN="\e[38;5;34m"
NOCOLOR="\e[0m"

read -p "Do you need to git pull latest? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] ; then
  printf "Git pull latest:\n"
  git pull origin master
  printf "${GREEN}OK${NOCOLOR}\n"
fi

printf '%-40s' "Backup existing dotfiles:"
[ ! -d "$BACKUP_DIR" ] && mkdir "$BACKUP_DIR"
cp -p $HOME/.bashrc $BACKUP_DIR/.
cp -p $HOME/.bash_aliases $BACKUP_DIR/.
cp -p $HOME/.vimrc $BACKUP_DIR/.
cp -pR $HOME/.vim $BACKUP_DIR/.
printf "${GREEN}OK${NOCOLOR}\n"

printf '%-40s' "Backup/create bin:"
if [ -d "$BIN_DIR" ] ; then
  cp -pR $BIN_DIR $BACKUP_DIR/.
else
  mkdir $BIN_DIR
fi
printf "${GREEN}OK${NOCOLOR}\n"

printf '%-40s' "Updating dotfiles:"
cp -p $DOTFILES/.bashrc $HOME/.
cp -p $DOTFILES/.bash_aliases $HOME/.
cp -p $DOTFILES/.vimrc $HOME/.
cp -pR $DOTFILES/.vim $HOME/.
cp -p $DOTFILES/fixperms.sh $BIN_DIR/.
printf "${GREEN}OK${NOCOLOR}\n"

read -p "Do you need to fix permissions? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] ; then
  $BIN_DIR/fixperms.sh -p$HOME -v
  printf "${GREEN}OK${NOCOLOR}\n"
fi
