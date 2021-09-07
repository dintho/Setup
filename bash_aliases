export EDITOR=vim
export VISUAL="$EDITOR"
alias cls='clear'
alias diff='diff --color=auto'
alias dir='dir --color=auto'
alias duks='du -kcs / |sort -m|head -15'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias la='ls -la --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias vdir='vdir --color=auto'
alias vi='vim'
alias xx='exit'

h() {
[[ -z $1 ]] && history
[[ -n $1 ]] && history|grep "$@"
}

jn() {
if [[ -z $PYENV_VIRTUAL_ENV ]]
then echo -e "no pyenv set"
else $PYENV_VIRTUAL_ENV/bin/jupyter-notebook --no-browser
fi
}

