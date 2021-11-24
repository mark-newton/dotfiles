# .bashrc
export PATH=$HOME/bin:/usr/local/bin:$PATH

if [ -f $HOME/.fzf.bash ];  then
  . $HOME/.fzf.bash
fi

if [ -f $HOME/.aliases ];  then
  . $HOME/.aliases
fi
if [ -f $HOME/.bash_aliases ];  then
  . $HOME/.bash_aliases
fi
if [ -f $HOME/.bash_aliases.user ];  then
  . $HOME/.bash_aliases.user
fi

# Hostname colours
BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
OWHITE="\033[0;37m"
LBLACK="\033[0;90m"
LRED="\033[0;91m"
LGREEN="\033[0;92m"
LYELLOW="\033[0;93m"
LBLUE="\033[0;94m"
LPURPLE="\033[0;95m"
LCYAN="\033[0;96m"
WHITE="\033[0;97m"
GRAY="\033[0;90m"
BGREEN="\033[38;5;34m"
BORANGE="\033[38;5;208m"
HN=`echo $HOSTNAME | cut -f1 -d "."`
if (( $UID == 0 )); then
  HOSTCOL=$RED
else
  HOSTCOL=$BLUE
fi
if [ -f $HOME/.host ];  then
  . $HOME/.host
fi
export HN HOSTCOL

# export LS_COLORS=
# export LSCOLORS=
# export CLICOLOR=1
export VISUAL=vim
export EDITOR=vim

# Set window/tab title (ssh only)
if [ -t 0 ];then
  echo -ne "\033]0;"$HN"\007"
fi

case "$TERM" in
  xterm*|rxvt*|screen*)
    bind '"\e[A"':history-search-backward
    bind '"\e[B"':history-search-forward
  ;;
esac

# Starship prompt
eval "$(starship init bash)"
