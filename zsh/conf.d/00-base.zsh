# Enable vi mode
bindkey -v

# Remap delete key to actually delete a char
bindkey "\e[3~" delete-char 

# Allow incremental search
bindkey '^R' history-incremental-pattern-search-backward
bindkey -M vicmd '/' history-incremental-pattern-search-backward

# Allow Shift + Tab to cycle menu backwards
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete

# Better history searching
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt inc_append_history
setopt share_history

