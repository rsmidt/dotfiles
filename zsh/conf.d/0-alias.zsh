alias dots='cd ~/.dotfiles'
alias vim='nvim'
alias vimrc='vim ~/.vimrc'
alias nvimrc='vim ~/.config/nvim/init.vm'
alias zshrc='vim ~/.zshrc'
alias i3conf='vim ~/.config/i3/conf.d/0-base.conf'
alias swayconf='vim ~/.config/sway/config'
alias zshreload='source ~/.zshrc'
alias vimreload='source ~/.vimrc'
alias vimtodo="vim -c ':tabnew | :TabooRename TODO' -c ':e todo.org' -c ':set textwidth=0' -c ':set wrapmargin=0' -c ':tabNext | :TabooRename Project'"
# Set term for ssh sessions
alias ssh='TERM=xterm-256color \ssh'
alias tmpdir='cd $(mktemp -d)'
