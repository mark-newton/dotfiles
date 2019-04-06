export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="/Users/marco/.oh-my-zsh"

#ZSH_THEME="robbyrussell"
#ZSH_THEME="hyperzsh"
ZSH_THEME="marco"

DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(git colorize pip python brew osx zsh-autosuggestions osx-dev)

source $ZSH/oh-my-zsh.sh

# User configuration
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi
export SSH_KEY_PATH="~/.ssh/rsa_id"
source ~/.aliases
source ~/.host
