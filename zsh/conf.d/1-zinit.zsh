### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

# Zplugin configuration

# LS_COLORS
zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

# Prompt
eval "$(starship init zsh)"

# Git plugin from OMZ
zinit wait lucid for \
        OMZL::git.zsh \
        OMZL::directories.zsh \
        OMZP::git

# Autosuggestions & fast-syntax-highlighting
zinit wait lucid for \
  atinit"zicompinit; zicdreplay"  \
        zdharma-continuum/fast-syntax-highlighting \
      OMZP::colored-man-pages \
  as"completion" \
        OMZP::docker/_docker

# asdf-vm
if [ -d "$HOME/.asdf" ]; then
  zinit ice wait lucid
  zinit light asdf-vm/asdf
fi

# zsh-autosuggestions
zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit load zsh-users/zsh-autosuggestions

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

# Rustup and Cargo
zinit ice wait lucid as"completion"
zinit load ~/.zinit/completions/_rustup

zinit ice wait lucid
zinit load ~/.zinit/completions/_cargo

