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

# Hostname
HN=`echo $HOSTNAME | cut -f1 -d "."`
if [ -f $HOME/.host ];  then
  . $HOME/.host
fi
export HN

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
  xterm*|rxvt*|screen*|tmux*)
    bind '"\e[A"':history-search-backward
    bind '"\e[B"':history-search-forward
  ;;
esac

# Starship prompt
eval "$(starship init bash)"
