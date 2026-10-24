export LANG=en_US.UTF-8

export GOPATH="$HOME/go"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# HISTSIZE > SAVEHIST for hist_expire_dups_first
HISTSIZE=120000
SAVEHIST=100000

export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"

export SDKMAN_DIR="$HOME/.sdkman"
export PNPM_HOME="$HOME/.pnpm"
