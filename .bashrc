# .bashrc

case "$TERM" in
  xterm*|rxvt*)
    bind '"\e[A"':history-search-backward
    bind '"\e[B"':history-search-forward
  ;;
esac
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
elif [ -f /etc/bash_completion.d/git ]; then
  . /etc/bash_completion.d/git
elif [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh ]; then
  source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
fi
if [ -f $HOME/.bash_aliases ];  then
  . $HOME/.bash_aliases
fi

# PS1 Constants
BLACK="\[\033[0;30m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
PURPLE="\[\033[0;35m\]"
CYAN="\[\033[0;36m\]"
WHITE="\[\033[0;37m\]"
LBLACK="\[\033[0;90m\]"
LRED="\[\033[0;91m\]"
LGREEN="\[\033[0;92m\]"
LYELLOW="\[\033[0;93m\]"
LBLUE="\[\033[0;94m\]"
LPURPLE="\[\033[0;95m\]"
LCYAN="\[\033[0;96m\]"

GRAY="\[\033[0;90m\]"
GREEN="\[\033[38;5;34m\]"
ORANGE="\[\033[38;5;208m\]"
RED="\[\033[38;5;160m\]"

NOCOLOR="\[\033[0m\]"
ORANGE=$LRED

HN=`echo $HOSTNAME | cut -f1 -d "."`
if (( $UID == 0 )); then
  UIDCOL=$RED
  HOSTCOL=$RED
  UIDCSR="#"
else
  UIDCOL=$BLUE
  HOSTCOL=$BLUE
  UIDCSR=">"
fi
case $HN in
  twp-marco)
    HN="local"
    HOSTCOL=$GREEN
    ;;
  vmxshpdb)
    HN="shopping-devdb"
    HOSTCOL=$GREEN
    ;;
  vmxshpdev)
    HN="shopping-dev"
    HOSTCOL=$GREEN
    ;;
  vmxshpstaging)
    HN="shopping-staging"
    HOSTCOL=$ORANGE
    ;;
  vmv15928)
    HN="shopping-prod"
    HOSTCOL=$RED
    ;;
  vmx15702)
    HN="shoply"
    HOSTCOL=$RED
    ;;
  ip-172-31-0-34)
    HN="yhd-prod"
    HOSTCOL=$RED
    ;;
esac

export "PS1=[$UIDCOL\u$GRAY@$HOSTCOL$HN$NOCOLOR]$GRAY\w"'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    echo "'$GREEN'"$(__git_ps1 " (%s)"); \
  else \
    echo "'$RED'"$(__git_ps1 " (%s)"); \
  fi)'$NOCOLOR$UIDCSR' "; \
else \
  echo "'$NOCOLOR$UIDCSR' "; \
fi)'

export PROMPT_DIRTRIM=3
export LS_COLORS=
export LSCOLORS=
export CLICOLOR=1
export VISUAL=vim
export EDITOR=vim
