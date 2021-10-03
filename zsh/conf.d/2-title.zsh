.update_title() {
    echo -e "\e]2;"${USER}"@"${HOSTNAME%%.*}":"${PWD/#$HOME/\~}"\e\\"
}
autoload -U add-zsh-hook
add-zsh-hook chpwd .update_title
.update_title
