export PATH=$HOME/bin:/usr/local/bin:$PATH

# Eval homebrew
if [[ -f "/usr/local/Homebrew/bin/brew" ]] then
  eval "$(/usr/local/Homebrew/bin/brew shellenv)"
fi

# Zinit plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Snippets (ie. Oh-my-zsh plugins)
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# Keybindings
bindkey -e    # -e emacs, -v vim
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^P' history-search-backword
bindkey '^N' history-search-forward
bindkey '^[w' kill-region

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

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Starship prompt
eval "$(starship init zsh)"

# Aliases
[ -f $HOME/.aliases ] && source $HOME/.aliases
[ -f $HOME/.host ] && source $HOME/.host

# Shell integrations
if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --zsh)"
else
    echo "*** You need to install fzf"
fi

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init --cmd cd zsh)"
else
    echo "*** You need to install zoxide"
fi

# Init shell
clear
fortune | cowsay -f tux
date
uptime
# . "$HOME/.local/bin/env"
