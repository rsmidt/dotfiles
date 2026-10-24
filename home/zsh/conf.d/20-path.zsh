# Directories that don't exist on this machine are dropped by the (N-/)
# qualifier below, so one list works on every machine. typeset -U keeps the
# first occurrence, so the system dirs after $path are only added if missing.
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
