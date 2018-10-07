# .bashrc

case "$TERM" in
  xterm*|rxvt*|screen*)
    bind '"\e[A"':history-search-backward
    bind '"\e[B"':history-search-forward
  ;;
esac

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
#elif [ -f /etc/bash_completion.d/git ]; then
#  . /etc/bash_completion.d/git
elif [ -f ~/bin/git-prompt.sh ]; then
  . ~/bin/git-prompt.sh
fi
if [ -f $HOME/.bash_aliases ];  then
  . $HOME/.bash_aliases
fi
if [ -f $HOME/.bash_aliases.user ];  then
  . $HOME/.bash_aliases.user
fi

# PS1 Constants
BLACK="\[\033[0;30m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
PURPLE="\[\033[0;35m\]"
CYAN="\[\033[0;36m\]"
OWHITE="\[\033[0;37m\]"
LBLACK="\[\033[0;90m\]"
LRED="\[\033[0;91m\]"
LGREEN="\[\033[0;92m\]"
LYELLOW="\[\033[0;93m\]"
LBLUE="\[\033[0;94m\]"
LPURPLE="\[\033[0;95m\]"
LCYAN="\[\033[0;96m\]"
WHITE="\[\033[0;97m\]"

GRAY="\[\033[0;90m\]"
GREEN="\[\033[38;5;34m\]"
ORANGE="\[\033[38;5;208m\]"
RED="\[\033[38;5;160m\]"
NOCOLOR="\[\033[0m\]"

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
if [ -f $HOME/.bash_host ];  then
  . $HOME/.bash_host
fi

# Set prompt
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

# Set window/tab title (ssh only)
if [ -t 0 ];then
  echo -ne "\033]0;"$HN"\007"
fi
