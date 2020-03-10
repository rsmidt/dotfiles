#!/bin/zsh

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

# Determine OS
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

# Set default project path
export PROJECT_PATH="$HOME/Projects"

# Set GOPATH
export GOPATH="$PROJECT_PATH/gocode"

# Configure Maven
export M2_HOME=/opt/maven
export M2=$M2_HOME/bin

# Append PATH
export PATH=$GOPATH/bin:$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin:$PATH

if [[ -d "/opt/texlive" ]]; then
    export PATH=/opt/texlive/2019/bin/x86_64-linux:$PATH
fi

if [[ -d "$HOME/.groovy" ]]; then
    export GROOVY_HOME=$HOME/.groovy
    export PATH=$HOME/.groovy/bin:$PATH
fi

# Set key timeouet to 1 for vi mode
export KEYTIMEOUT=1

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory


# This gets rid of the annoying tab completion bug (cdcd, sshssh etc.)
# May not needed everywhere
# export LC_CTYPE=en_DE.UTF-8

# https://discourse.brew.sh/t/failed-to-set-locale-category-lc-numeric-to-en-ru/5092/12
if [[ $machine == Mac ]]; then
    export LC_ALL=en_US.UTF-8
fi

# Default editor ist nvim
export EDITOR="nvim"

# Configure FZF to use Ripgrep
export FZF_DEFAULT_COMMAND='rg --files --hidden'

# Fix Java windows in sway
export _JAVA_AWT_WM_NONREPARENTING=1

# Aliases
alias dots='cd ~/.dotfiles'
alias vim='nvim'
alias vimrc='vim ~/.vimrc'
alias nvimrc='vim ~/.config/nvim/init.vm'
alias zshrc='vim ~/.zshrc'
alias i3conf='vim ~/.config/i3/config'
alias swayconf='vim ~/.config/sway/config'
alias mux='tmuxinator'

# Only alias open on linux
if [[ $machine == Linux ]]; then
    alias open='xdg-open'
fi

alias tgi="cd $PROJECT_PATH/tgi-sose.2019"

alias zshreload='source ~/.zshrc'
alias vimreload='source ~/.vimrc'

alias vimtodo="vim -c ':tabnew | :TabooRename TODO' -c ':e todo.org' -c ':set textwidth=0' -c ':set wrapmargin=0' -c ':tabNext | :TabooRename Project'"
alias vimupdate="vim +PlugUpdate +qall"

alias gbdrm='git branch --merged | grep -v "^[ *]*master$" >/tmp/merged-branches && vi /tmp/merged-branches && xargs git branch -d </tmp/merged-branches'

alias cbh='bluetoothctl connect 00:1B:66:83:1F:3E'
alias dbh='bluetoothctl disconnect 00:1B:66:83:1F:3E'

# Apply wal schemes
if type wal >/dev/null; then
     cat ~/.cache/wal/sequences
fi

# If sway is installed, start it because we probably are not using a login manager
if type sway >/dev/null; then
    if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
      exec sway
    fi
fi

# Apply pip completion only if pip is installed
if type pip >/dev/null; then
    eval "`pip completion --zsh`"
    compctl -K _pip_completion pip3
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
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

# Completions
zinit ice wait atinit"zstyle ':completion:*' menu select" blockf lucid
zinit light zsh-users/zsh-completions

# Autosuggestions
zinit ice wait atload"_zsh_autosuggest_start" lucid
zinit load zsh-users/zsh-autosuggestions

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

# Syntax highlighting
zinit ice wait atinit"zpcompinit; zpcdreplay" lucid
zinit light zdharma/fast-syntax-highlighting

# Common git aliases from OMZ
zinit ice wait lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh

# Common directory aliases from OMZ
zinit ice wait atload"unalias grv" lucid
zinit snippet OMZ::lib/directories.zsh

# Rustup and Cargo
zinit ice wait lucid
zinit load ~/.zinit/completions/_rustup

zinit ice wait lucid
zinit load ~/.zinit/completions/_cargo

# Docker and docker-composse
zinit ice wait lucid as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zinit ice wait lucid as"completion"
zinit snippet https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose

typeset -aU path

# Use gpg-agent for instead of the default ssh-agent
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ruben/google-cloud-sdk/path.zsh.inc' ]; then . '/home/ruben/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ruben/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/ruben/google-cloud-sdk/completion.zsh.inc'; fi
