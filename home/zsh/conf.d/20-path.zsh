# (N-/) drops directories that don't exist on this machine
typeset -U path
path=(
    $HOME/.tfenv/bin
    $HOME/.rd/bin
    $PNPM_HOME
    $HOME/.mix/escripts
    $GOPATH/bin
    $HOME/.local/bin
    $HOME/bin
    $HOME/.cargo/bin
    $HOME/.devcontainers/bin
    $path
    /usr/local/bin
    /usr/sbin
    $HOME/.spicetify
    $HOME/.local/share/JetBrains/Toolbox/scripts
)
path=(${^path}(N-/))
