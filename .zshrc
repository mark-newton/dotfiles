# Eval homebrew
if [[ -f "/usr/local/Homebrew/bin/brew" ]] then
  eval "$(/usr/local/Homebrew/bin/brew shellenv)"
fi

# Shell integrations
if command -v fzf >/dev/null 2>&1; then
    export FZF_DEFAULT_OPTS="--style minimal --color 16 --layout=reverse --height 30% --preview='bat -p --color=always {}'"
    export FZF_CTRL_R_OPTS="--style minimal --color 16 --info inline --no-sort --no-preview"
    source <(fzf --zsh)
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

# These doesn't seem to play nice with ghostty, leave it as default (xterm-ghostty)
# The xterm-ghostty terminfo works fine in tmux/neovim with undercurls/colours
# In the .host ssh aliases I put use a TERM prefix to resolve remote ssh terminfo issues
# export TERM="tmux-256color"

[ -f $HOME/.aliases ] && source $HOME/.aliases
[ -f $HOME/.host ] && source $HOME/.host

path=(
    $path
    $HOME/bin
    $HOME/.local/bin
    /usr/local/bin
)
typeset -U path
path=($^path(N-/))
export PATH 

# Zinit plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Keybindings
bindkey -v    # -e emacs, -v vim
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey '^[w' kill-region
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# History
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Starship prompt
eval "$(starship init zsh)"

# Init shell
fortune | cowsay -f tux
date
uptime
# . "$HOME/.local/bin/env"
