#!/usr/bin/env bash
HILITE="\e[38;5;34m"
NC="\e[0m"
NVIM_CONFIG=".config/nvim"

cd "$(dirname "${BASH_SOURCE}")";

# Check if .gitmodules exists and nvim submodule directory is empty or missing
if [ -f ".gitmodules" ]; then
  if [ ! -f "$NVIM_CONFIG/.git" ]; then
    printf "Initialising submodules...\n"
    git submodule update --init --recursive
  fi
fi

git pull origin master
if [ -f "$NVIM_CONFIG/.git" ]; then
git submodule update --remote --merge
elif [ -d "$NVIM_CONFIG/.git" ]; then
cd $NVIM_CONFIG
git pull origin master
fi
if [ -d "$HOME/$NVIM_CONFIG/.git" ]; then
cd $HOME/$NVIM_CONFIG
git pull origin master
fixperms
fi
printf '%-40s' "Git pulled latest:"
printf "${HILITE}OK${NC}\n"
cd "$(dirname "${BASH_SOURCE}")";
fixperms
printf '%-40s' "Fixed permissions:"
printf "${HILITE}OK${NC}\n"
