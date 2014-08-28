#.bash_profile

# ----- vi bash prompt mode and set vim as editor -----------------------------

set editing-mode vi
set keymap vi
set -o vi
export EDITOR="vim"

# ----- alias doges -----------------------------------------------------------

alias pyhttp='python -m SimpleHTTPServer'
alias lsh='ls -a | egrep "^\."'

# ----- set default output for ls; add auto ls after cd -----------------------

if [[ "$(uname)" == "Darwin" ]]; then
    alias ls='ls -G'
else
    alias ls='ls --color'
fi

cdls () {
    cd "$1"
    local cderr="$?"
    if [[ "$cderr" -eq '0' ]]; then
        [[ "$1" = '-' ]] || pwd
        shift
        ls "$@"
    fi
    return "$cderr"
}
alias cd='cdls'

# ----- Prompt config ---------------------------------------------------------

ps1_color_error () {
    if [[ "$1" -eq 0 ]]; then
        printf '32'
    else
        printf '31'
    fi;
    exit $1
}
ps1_value_error () {
    if [[ "$1" -gt 0 ]]; then
        printf " $1 "
    fi;
}
export PS1='\[\033[0;$(ps1_color_error $?)m\]$(ps1_value_error $?)\u\[\033[0;34m\] \W)\[\033[0m\] '
