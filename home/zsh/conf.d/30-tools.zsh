[[ -s $SDKMAN_DIR/bin/sdkman-init.sh ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

(( $+commands[mise] )) && eval "$(mise activate zsh)"
(( $+commands[fzf] )) && eval "$(fzf --zsh)"
(( $+commands[starship] )) && eval "$(starship init zsh)"
