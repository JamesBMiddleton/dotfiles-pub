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

# nord colorscheme - rgb+cmyk+gray+white
echo -en "\e]P02e3440" #black (nord0)
echo -en "\e]P1bf616a" #darkred (nord11) 
echo -en "\e]P2a3be8c" #darkgreen (nord14)
echo -en "\e]P3ebcb8b" #darkyellow (nord13)
echo -en "\e]P45e81ac" #darkblue (nord10)
echo -en "\e]P58c6f85" #darkmagenta (nord15)
echo -en "\e]P688c0d0" #darkcyan (nord8)
echo -en "\e]P7c0c4cf" #lightgray (nord4-darkened)
echo -en "\e]P84c566a" #darkgray (nord3)
# repeats
echo -en "\e]P9bf616a" #red (nord11)
echo -en "\e]PAa3be8c" #green (nord14)
echo -en "\e]PBebcb8b" #yellow (nord13)
echo -en "\e]PC5e81ac" #blue (nord9)
echo -en "\e]PDb48ead" #magenta (nord15)
echo -en "\e]PE88c0d0" #cyan (nord8)
echo -en "\e]PFc0c4cf" #white (nord4-darkened)


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
