#!/usr/bin/env bash
DOTFILES="$HOME/.dotfiles"
BACKUP_DIR="$DOTFILES/backups"

echo "Backing up existing dotfiles"
[ ! -d "$BACKUP_DIR" ] && mkdir "$BACKUP_DIR"
cp -p $HOME/.bashrc $BACKUP_DIR/.
cp -p $HOME/.bash_aliases $BACKUP_DIR/.
cp -p $HOME/.vimrc $BACKUP_DIR/.
cp -pR $HOME/.vim $BACKUP_DIR/.

echo "Updating live dotfiles"
cp -p $DOTFILES/.bashrc $HOME/.
cp -p $DOTFILES/.bash_aliases $HOME/.
cp -p $DOTFILES/.vimrc $HOME/.
cp -pR $DOTFILES/.vim $HOME/.

