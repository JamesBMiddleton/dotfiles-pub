#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more standard ls aliases
alias ll='ls -alF'

PS1='\[\033[01;32m\]\h\[\033[00m\]:\w\$ '

# ANSI-compliant 3-bit darkplus theme
echo -en "\e]P01e1e1e" #black
echo -en "\e]P1ce9178" #red
echo -en "\e]P24ec9b0" #green
echo -en "\e]P3dcdcaa" #yellow
echo -en "\e]P4569cd6" #blue
echo -en "\e]P5c586c0" #magenta
echo -en "\e]P69cdcfe" #cyan
echo -en "\e]P7c8c8c8" #white
# repeat colors for terminals supporting 4-bit
echo -en "\e]P8c8c8c8" #brightgray
echo -en "\e]P9ce9178" #brightred
echo -en "\e]PA4ec9b0" #brightgreen
echo -en "\e]PBdcdcaa" #brightyellow
echo -en "\e]PC569cd6" #brightblue
echo -en "\e]PDc586c0" #brightmagenta
echo -en "\e]PE9cdcfe" #brightcyan
echo -en "\e]PFc8c8c8" #brightwhite

# create a sandbox for a given language
sandbox ()
{
    rm -rf $HOME/sandbox >/dev/null 2>&1
    mkdir $HOME/sandbox
    cd $HOME/sandbox/
    mkdir scripts
    touch scripts/run.sh
    chmod +x scripts/run.sh
    if [ $1 = "c" ]; then
        printf '#!/bin/bash\ngcc main.c\n./a.out\n' > scripts/run.sh
        printf '#include <stdio.h>\n #include <stdlib.h>\n\nint main()\n{\n    return 0;\n}' > main.c
        nvim $HOME/sandbox/main.c
    fi
}

export TZ=Europe/London

tmux
