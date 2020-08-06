# .bashrc
export PATH=$HOME/bin:/usr/local/bin:$PATH

case "$TERM" in
  xterm*|rxvt*|screen*)
    bind '"\e[A"':history-search-backward
    bind '"\e[B"':history-search-forward
  ;;
esac

if [ -f $HOME/.fzf.bash ];  then
  . $HOME/.fzf.bash
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
#elif [ -f /etc/bash_completion.d/git ]; then
#  . /etc/bash_completion.d/git
elif [ -f ~/bin/git-prompt.sh ]; then
  . ~/bin/git-prompt.sh
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
BGREEN="\[\033[38;5;34m\]"
BORANGE="\[\033[38;5;208m\]"
BRED="\[\033[38;5;160m\]"
NOCOLOR="\[\033[0m\]"

TICK=$'\u2713'
CROSS=$'\u2717'
DOT=$'\u25CF'
RANGLE=$'\u276F'
RARROW=$'\u279C'

HN=`echo $HOSTNAME | cut -f1 -d "."`
if (( $UID == 0 )); then
  UIDCOL=$RED
  HOSTCOL=$RED
  UIDNAME=$UIDCOL\\u@
  UIDCSR=$BRED$RANGLE
else
  UIDCOL=$GRAY
  HOSTCOL=$BLUE
  UIDNAME="$UIDCOL"
  UIDCSR=$WHITE$RANGLE
fi
if [ -f $HOME/.host ];  then
  . $HOME/.host
fi

# Set prompt
export PS1="$GRAY\t $UIDNAME$HOSTCOL$HN:$BLUE\w $UIDCSR $NOCOLOR"
if [ -f $HOME/.bash-git-prompt/gitprompt.sh ];  then
  GIT_PROMPT_ONLY_IN_REPO=1
  GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=0
  GIT_PROMPT_FETCH_REMOTE_STATUS=0
  GIT_PROMPT_THEME=Single_line_Custom
  source ~/.bash-git-prompt/gitprompt.sh
fi

export PROMPT_DIRTRIM=2
export LS_COLORS=
export LSCOLORS=
export CLICOLOR=1
export VISUAL=vim
export EDITOR=vim

# Set window/tab title (ssh only)
if [ -t 0 ];then
  echo -ne "\033]0;"$HN"\007"
fi
