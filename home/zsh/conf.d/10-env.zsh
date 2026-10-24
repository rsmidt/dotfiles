export LANG=en_US.UTF-8

export GOPATH="$HOME/go"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# oh-my-zsh defaults to 50000/10000. Keep HISTSIZE above SAVEHIST so
# hist_expire_dups_first (set by oh-my-zsh) has room to drop duplicates.
HISTSIZE=120000
SAVEHIST=100000

export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"

export SDKMAN_DIR="$HOME/.sdkman"
export PNPM_HOME="$HOME/.pnpm"
