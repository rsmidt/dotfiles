#!/bin/zsh

# Detect OS:
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

export PROJECTPATH="$HOME/Projects"
export GOPATH="$PROJECTPATH/gocode"

export M2_HOME=/opt/maven
export M2=$M2_HOME/bin

# If you come from bash you might have to change your $PATH.
export PATH=$PATH:$GOPATH/bin:$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin

# This gets rid of the annoying tab completion bug (cdcd, sshssh etc.)
# export LC_CTYPE=en_DE.UTF-8

# https://discourse.brew.sh/t/failed-to-set-locale-category-lc-numeric-to-en-ru/5092/12
if [[ $machine == Mac ]]; then
    export LC_ALL=en_US.UTF-8
fi

export MAN_POSIXLY_CORRECT=1

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

export FZF_DEFAULT_COMMAND='rg --files --hidden'

export _JAVA_AWT_WM_NONREPARENTING=1

# Aliases
alias vim='nvim'
alias vimrc='vim ~/.vimrc'
alias nvimrc='vim ~/.config/nvim/init.vm'
alias zshrc='vim ~/.zshrc'
alias i3conf='vim ~/.config/i3/config'
alias swayconf='vim ~/.config/sway/config'
alias mux='tmuxinator'

alias tgi="cd $PROJECTPATH/tgi-sose.2019"

alias zshreload='source ~/.zshrc'
alias vimreload='source ~/.vimrc'

alias vimtodo="vim -c ':tabnew | :TabooRename TODO' -c ':e todo.org' -c ':set textwidth=0' -c ':set wrapmargin=0' -c ':tabNext | :TabooRename Project'"

alias gbdrm='git branch --merged | grep -v "^[ *]*master$" >/tmp/merged-branches && vi /tmp/merged-branches && xargs git branch -d </tmp/merged-branches'

# Apply wal schemes
if type wal >/dev/null; then
     cat ~/.cache/wal/sequences
fi

if type sway >/dev/null; then
    if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
      exec sway
    fi
fi

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="lambda-mod"

# source ~/tmuxinator/completion/tmuxinator.zsh

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ng python redis-cli yarn)

source $ZSH/oh-my-zsh.sh

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

export EDITOR="nvim"

if type pip >/dev/null; then
    eval "`pip completion --zsh`"
    compctl -K _pip_completion pip3
fi

gocd () { cd `go list -f '{{.Dir}}' $1`  }
lsproj () {
    print $fg[red]"Projects in default dir:" 
    ls $HOME/Projects
    print $fg[white]"---------------------------------------------------------------------"
    print $fg[red]"Projects in user GOPATH:"
    ls $GOPATH/src/gitlab.com/rsmidt
}
cdp () {
    if [[ -d "$HOME/Projects" ]]; then
        ITEMS=($HOME/Projects/*)
    fi
    
    if [[ -d "$HOME/Projects/gocode/src/gitlab.com/rsmidt" ]]; then
        ITEMS+=($GOPATH/src/gitlab.com/rsmidt/*)
    fi

    for item in $ITEMS; do
        if [[ ! -d $item ]]; then
            delete=($item)
        fi
        FOLDERS=("${ITEMS[@]/$delete}")
    done

    WORKPSPACES=()

    for folder in $FOLDERS; do
        if [[ "${folder##*/}" = "${@[1]}" ]]; then
            WORKSPACES+=($folder)
        fi
    done

    if [[ ${#WORKSPACES} -gt 1 ]]; then
        echo "I found more than one project with the same name, which do you want?\n"
        i=1
        for ws in $WORKSPACES; do
            echo "$i: $ws"
            ((i++))
        done

        local choice
        vared choice
    else
        choice=1
    fi

    if [[ -d ${WORKSPACES[$choice]} ]]; then
        cd $WORKSPACES[$choice]
    else
        cd $PROEJCTPATH
    fi
    unset WORKSPACES
    unset ITEMS
}
