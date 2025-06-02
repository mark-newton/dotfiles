#!/usr/bin/env bash
BACKUP_DIR="backups"
GITUSER_FILE=".gitconfig.user"
HOST_FILE=".host"
HILITE="\e[38;5;34m"
NC="\e[0m"
STARSHIP_FILE=".config/starship.toml"

cd "$(dirname "${BASH_SOURCE}")";

# Check if .gitmodules exists and nvim submodule directory is empty or missing
if [ -f ".gitmodules" ]; then
  if [ ! -d ".config/nvim/.git" ]; then
    printf "Initialising submodules...\n"
    git submodule update --init --recursive
  fi
fi

read -p "Do you need to git pull latest? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] ; then
  git pull origin master
  git submodule update --remote --merge
  printf '%-40s' "Git pulled latest:"
  printf "${HILITE}OK${NC}\n"
  fixperms
  printf '%-40s' "Fixed permissions:"
  printf "${HILITE}OK${NC}\n"
fi

if ! command -v starship &> /dev/null
then
    printf "Starship prompt needs to be installed...\n"
    sh -c "$(curl -fsSL https://starship.rs/install.sh)"
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
  printf "Avail styles: black, red, green, blue, yellow, purple, cyan, white, bright-*\n"
  printf "Enter host colour for prompt: "
  read pcol
  printf '%-40s' "Host file created:"
  export HN="$phost"
  export HCOL="$pcol"
  printf "export HN=\"${phost%}\"\nexport HCOL=\"${pcol%}\"\n" > "$HOST_FILE"
  printf "${HILITE}OK${NC}\n"
fi
printf '%-40s' "Starship config updated:"
sed -i -e "/^\[custom\.hostname\]$/ { n; s/^format *=.*/format = '[${HN}](${HCOL})'/; }" "$STARSHIP_FILE"
printf "${HILITE}OK${NC}\n"

if [[ ! -f "$GITUSER_FILE" ]] ; then
  printf "Creating git config user settings...\n"
  printf "Enter git config author name: "
  read gitname
  printf "Enter git config author email: "
  read gitemail
  printf "[user]\n  name = $gitname\n  email = $gitemail\n" > "$GITUSER_FILE"
  read -p "Are you running neovim? " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]] ; then
    printf "[merge]\n  tool = vimdiff\n[mergetool]\n  prompt = true\n[mergetool "vimdiff"]\n  cmd = nvim -d \$LOCAL \$REMOTE \$MERGED -c '\$wincmd w' -c 'wincmd J'\n[difftool]\n  prompt = true\n[diff]\n  tool = vimdiff\n" >> "$GITUSER_FILE"
  fi
  printf '%-40s' "Git user config file created:"
  printf "${HILITE}OK${NC}\n"
fi
