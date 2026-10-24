[[ -s $SDKMAN_DIR/bin/sdkman-init.sh ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
[[ -s $BUN_INSTALL/_bun ]] && source "$BUN_INSTALL/_bun"
[[ -f $HOME/.dart-cli-completion/zsh-config.zsh ]] && source "$HOME/.dart-cli-completion/zsh-config.zsh"
[[ -f $HOME/.local/bin/env ]] && source "$HOME/.local/bin/env"

(( $+commands[mise] )) && eval "$(mise activate zsh)"
(( $+commands[fzf] )) && eval "$(fzf --zsh)"
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
(( $+commands[starship] )) && eval "$(starship init zsh)"
