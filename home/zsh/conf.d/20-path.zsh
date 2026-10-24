# Directories that don't exist on this machine are dropped by the (N-/)
# qualifier below, so one list works on every machine.
typeset -U path
path=(
    $HOME/.tfenv/bin
    $BUN_INSTALL/bin
    $HOME/.rd/bin
    $PNPM_HOME
    $HOME/.mix/escripts
    $GOPATH/bin
    $HOME/.local/bin
    $HOME/bin
    $HOME/.cargo/bin
    /usr/sbin
    /usr/local/bin
    $HOME/.devcontainers/bin
    $path
    $ANDROID_HOME/emulator
    $ANDROID_HOME/platform-tools
    $HOME/.spicetify
    $HOME/.local/share/JetBrains/Toolbox/scripts
)
path=(${^path}(N-/))
