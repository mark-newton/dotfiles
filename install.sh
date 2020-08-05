#!/usr/bin/env bash
BACKUP_DIR="backups"
GITUSER_FILE=".gitconfig.user"
HOST_FILE=".host"
HILITE="\e[38;5;34m"
NC="\e[0m"

cd "$(dirname "${BASH_SOURCE}")";

read -p "Do you need to git pull latest? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] ; then
  git pull origin master
  printf '%-40s' "Git pulled latest:"
  printf "${HILITE}OK${NC}\n"
  fixperms
  printf '%-40s' "Fixed permissions:"
  printf "${HILITE}OK${NC}\n"
fi

BACKUP_DIR=$(pwd)/$BACKUP_DIR
[ ! -d "$BACKUP_DIR" ] && mkdir "$BACKUP_DIR"

printf "Rsyncing dotfiles...\n"
rsync \
  --exclude "*.0" \
  --exclude ".DS_Store" \
  --exclude ".git/" \
  --exclude ".gitignore" \
  --exclude "*.swp" \
  --exclude "backups" \
  --exclude "install.sh" \
  -abh --backup-dir=$BACKUP_DIR --out-format='%n%L' . ~;
printf '%-40s' "Updated dotfiles:"
printf "${HILITE}OK${NC}\n"

cd

if [[ ! -f "$HOST_FILE" ]] ; then
  printf "Creating host settings...\n"
  printf "Enter hostname for prompt: "
  read phost
  printf "Avail colours: RED/GREEN/YELLOW/BLUE/PURPLE/CYAN/OWHITE/L*/GRAY/BRED/BGREEN/BORANGE\n"
  printf "Enter host colour for prompt: "
  read pcol
  printf "HN=\"${phost}\"\nHOSTCOL=\$${pcol}\n" > "$HOST_FILE"
  printf '%-40s' "Host file created:"
  printf "${HILITE}OK${NC}\n"
fi

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
