# .bashrc
export PATH=$HOME/bin:/usr/local/bin:$PATH

if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_OPTS="--style minimal --color 16 --layout=reverse --height 30% --preview='bat -p --color=always {}'"
  export FZF_CTRL_R_OPTS="--style minimal --color 16 --info inline --no-sort --no-preview"
  eval "$(fzf --bash)"
else
  echo "*** You need to install fzf"
fi

# Env and path
if command -v nvim >/dev/null 2>&1; then
  export VISUAL=nvim
  export EDITOR=nvim
else
  export VISUAL=vi
  export EDITOR=vi
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

HISTSIZE=20000
HISTFILESIZE=20000
HISTIGNORE=”ls:ll:exit:clear:cd:top:htop*:history*”
HISTCONTROL=ignoreboth:erasedups 
shopt -s histappend 
shopt -s cmdhist

# Starship prompt
eval "$(starship init bash)"
