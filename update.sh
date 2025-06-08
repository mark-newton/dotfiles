#!/usr/bin/env bash
HILITE="\e[38;5;34m"
NC="\e[0m"

cd "$(dirname "${BASH_SOURCE}")";

# Check if .gitmodules exists and nvim submodule directory is empty or missing
if [ -f ".gitmodules" ]; then
  if [ ! -d ".config/nvim/.git" ]; then
    printf "Initialising submodules...\n"
    git submodule update --init --recursive
  fi
fi

git pull origin master
git submodule update --remote --merge
printf '%-40s' "Git pulled latest:"
printf "${HILITE}OK${NC}\n"
fixperms
printf '%-40s' "Fixed permissions:"
printf "${HILITE}OK${NC}\n"
