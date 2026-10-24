export LANG=en_US.UTF-8

# Set default project path
export PROJECT_PATH="$HOME/Projects"
export GOPATH="$HOME/go"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export HISTSIZE=10000
export SAVEHIST=10000

export FZF_DEFAULT_COMMAND='rg --files --hidden'

export SDKMAN_DIR="$HOME/.sdkman"
export PNPM_HOME="$HOME/.pnpm"
export BUN_INSTALL="$HOME/.bun"

if [[ -d $HOME/Android ]]; then
    export ANDROID_HOME=$HOME/Android/Sdk
    export ANDROID_AVD_HOME=$HOME/.config/.android/avd
fi
