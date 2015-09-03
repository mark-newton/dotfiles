#!/usr/bin/env bash
BACKUP_DIR="backups"
GITUSER_FILE=".gitconfig.user"
HILITE="\e[38;5;34m"
NC="\e[0m"

cd "$(dirname "${BASH_SOURCE}")";

read -p "Do you need to git pull latest? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] ; then
  git pull origin master
  printf '%-40s' "Git pulled latest:"
  printf "${HILITE}OK${NC}\n"
  ./bin/fixperms.sh
  printf '%-40s' "Fixed permissions:"
  printf "${HILITE}OK${NC}\n"
fi

[ ! -d "$BACKUP_DIR" ] && mkdir "$BACKUP_DIR"
cp -p ~/.bashrc $BACKUP_DIR/.
cp -p ~/.bash_aliases $BACKUP_DIR/.
cp -p ~/.gitconfig $BACKUP_DIR/.
cp -p ~/.vimrc $BACKUP_DIR/.
cp -pR ~/.vim $BACKUP_DIR/.
printf '%-40s' "Backed up existing dotfiles:"
printf "${HILITE}OK${NC}\n"

rsync \
  --exclude ".0" \
  --exclude ".DS_Store" \
  --exclude ".git/" \
  --exclude ".gitignore" \
  --exclude ".swp" \
  --exclude "backups" \
  --exclude "install.sh" \
  -avh . ~;
printf '%-40s' "Updated dotfiles:"
printf "${HILITE}OK${NC}\n"

cd

if [[ ! -f "$GITUSER_FILE" ]] ; then
  printf "Creating git config user settings...\n"
  printf "Enter git config author name: "
  read gitname
  printf "Enter git config author email: "
  read gitemail
  printf "[user]\n  name = $gitname\n  email = $gitemail\n" > "$GITUSER_FILE"
  printf '%-40s' "Git user config file created:"
  printf "${HILITE}OK${NC}\n"
fi

