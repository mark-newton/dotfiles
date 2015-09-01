#!/usr/bin/env bash
DOTFILES="$HOME/.dotfiles"
BACKUP_DIR="$DOTFILES/backups"
BIN_DIR="$HOME/bin"

echo "Backing up existing dotfiles"
[ ! -d "$BACKUP_DIR" ] && mkdir "$BACKUP_DIR"
cp -p $HOME/.bashrc $BACKUP_DIR/.
cp -p $HOME/.bash_aliases $BACKUP_DIR/.
cp -p $HOME/.vimrc $BACKUP_DIR/.
cp -pR $HOME/.vim $BACKUP_DIR/.

echo "Backing up/creating bin"
if [ -d "$BIN_DIR" ]
then
  cp -pR $BIN_DIR $BACKUP_DIR/.
else
  mkdir $BIN_DIR
fi

echo "Updating live dotfiles"
cp -p $DOTFILES/.bashrc $HOME/.
cp -p $DOTFILES/.bash_aliases $HOME/.
cp -p $DOTFILES/.vimrc $HOME/.
cp -pR $DOTFILES/.vim $HOME/.
cp -p $DOTFILES/fixperms.sh $BIN_DIR/.

echo "Fix permissions"
$BIN_DIR/fixperms.sh -p$HOME -v
