# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# Source Global Definitions
if [ -f /etc/bashrc ]
    then . /etc/bashrc
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoredups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
HISTTIMEFORMAT="%F %T "


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar


# Advanced command-not-found hook
if [[ -f  /usr/share/doc/find-the-command/ftc.bash ]];then
source /usr/share/doc/find-the-command/ftc.bash
fi
# Load starship prompt if starship is installed
if  [ -x /usr/bin/starship ] && [[ $TERM != "dumb" ]]; then
    __main() {
        local major="${BASH_VERSINFO[0]}"
        local minor="${BASH_VERSINFO[1]}"

        if ((major > 4)) || { ((major == 4)) && ((minor >= 1)); }; then
            source <("/usr/bin/starship" init bash --print-full-init)
        else
            source /dev/stdin <<<"$("/usr/bin/starship" init bash --print-full-init)"
        fi
    }
    __main
    unset -f __main
else
    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi
    
    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color|*-256color) color_prompt=yes;;
    esac
    
    
    #pyenv config
    if command -v pyenv 1>/dev/null 2>&1; then
    export PATH="~/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    fi
    
    # uncomment for a colored prompt, if the terminal has the capability; turned
    # off by default to not distract the user: the focus in a terminal window
    # should be on the output of commands, not on the prompt
    force_color_prompt=yes
    
    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    	# We have color support; assume it's compliant with Ecma-48
    	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    	# a case would tend to support setf rather than setaf.)
    	color_prompt=yes
        else
    	color_prompt=
        fi
    fi
    
    
    if [ "$color_prompt" = yes ]; then
        # override default virtualenv indicator in prompt
        VIRTUAL_ENV_DISABLE_PROMPT=1
        check_prev_cmd() { [ $? = 0 ] && echo ✅ || echo ❌;}
        prompt_color='\[\033[;32m\]'
        info_color='\[\033[1;34m\]'
        prompt_symbol=🐊
        if [ "$EUID" -eq 0 ]; then # Change prompt colors for root user
    	prompt_color='\[\033[;94m\]'
    	info_color='\[\033[1;31m\]'
    	prompt_symbol=💀
        fi
        if [ -f /etc/bash_completion.d/git-prompt* ] || [ -f ~/.git-prompt.sh ]; then # Setting GIT PS1 Options
            #source /etc/bash_completion.d/git-prompt.sh 
            #source ~/.git-prompt.sh # https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
            git_info_color='\[\033[;93m\]'
            export GIT_PS1_SHOWDIRTYSTATE="true"
            export GIT_PS1_SHOWSTASHSTATE="true"
            export GIT_PS1_SHOWUNTRACKEDFILES="true"
            export GIT_PS1_SHOWUPSTREAM="verbose name"
            export GIT_PS1_SHOWCOLORHINTS="true"
            export GIT_PS1_DESCRIBE_STYLE="branch"
            PS1=$prompt_color'┌──('$info_color'\u${prompt_symbol}\h'$prompt_color')${debian_chroot:+($debian_chroot)──}${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)'$prompt_color')}'$git_info_color'$(__git_ps1)'$prompt_color'-[\[\033[0;1m\]\w'$prompt_color']$(check_prev_cmd)\n'$prompt_color'└─'$info_color'\$\[\033[0m\] '
        else PS1=$prompt_color'┌──('$info_color'\u${prompt_symbol}\h'$prompt_color')${debian_chroot:+($debian_chroot)──}${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)'$prompt_color')}-[\[\033[0;1m\]\w'$prompt_color']$(check_prev_cmd)\n'$prompt_color'└─'$info_color'\$\[\033[0m\] '
        fi
    else
        PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    fi
    unset color_prompt force_color_prompt
    
    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
    esac
    
    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    if ! shopt -oq posix; then
      if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
      elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
      fi
    fi

fi

set -o vi
export EDITOR=vim
export VISUAL="$EDITOR"
# Alias definitions.
source ~/.shell_aliases
