#!/bin/zsh

# Enable vi mode
bindkey -v

# Remap delete key to actually delete a char
bindkey "\e[3~" delete-char 

# Allow Shift + Tab to cycle menu backwards
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete

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
export PROJEC_TPATH="$HOME/Projects"

# Set GOPATH
export GOPATH="$PROJECT_PATH/gocode"

# Configure Maven
export M2_HOME=/opt/maven
export M2=$M2_HOME/bin

# Append PATH
export PATH=$GOPATH/bin:$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin:$PATH

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
alias vim='nvim'
alias vimrc='vim ~/.vimrc'
alias nvimrc='vim ~/.config/nvim/init.vm'
alias zshrc='vim ~/.zshrc'
alias i3conf='vim ~/.config/i3/config'
alias swayconf='vim ~/.config/sway/config'
alias mux='tmuxinator'

alias tgi="cd $PROJECT_PATH/tgi-sose.2019"

alias zshreload='source ~/.zshrc'
alias vimreload='source ~/.vimrc'

alias vimtodo="vim -c ':tabnew | :TabooRename TODO' -c ':e todo.org' -c ':set textwidth=0' -c ':set wrapmargin=0' -c ':tabNext | :TabooRename Project'"

alias gbdrm='git branch --merged | grep -v "^[ *]*master$" >/tmp/merged-branches && vi /tmp/merged-branches && xargs git branch -d </tmp/merged-branches'


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


### Added by Zplugin's installer
source '/Users/ruben.smidt/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

# Zplugin configuration

# LS_COLORS
zplugin ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zplugin light trapd00r/LS_COLORS

# Prompt
zplugin light geometry-zsh/geometry

# Completions
zplugin ice wait atinit"zstyle ':completion:*' menu select" blockf lucid
zplugin light zsh-users/zsh-completions

# Autosuggestions
zplugin ice wait atload"_zsh_autosuggest_start" lucid
zplugin load zsh-users/zsh-autosuggestions

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

# Syntax highlighting
zplugin ice wait atinit"zpcompinit; zpcdreplay" lucid
zplugin light zdharma/fast-syntax-highlighting

# Common git aliases from OMZ
zplugin ice wait lucid
zplugin snippet OMZ::plugins/git/git.plugin.zsh

# Common directory aliases from OMZ
zplugin ice wait atload"unalias grv" lucid
zplugin snippet OMZ::lib/directories.zsh

# Rustup and Cargo
zplugin ice wait lucid
zplugin load ~/.zplugin/completions/_rustup

zplugin ice wait lucid
zplugin load ~/.zplugin/completions/_cargo

# Docker and docker-composse
zplugin ice wait lucid as"completion"
zplugin snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zplugin ice wait lucid as"completion"
zplugin snippet https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose
