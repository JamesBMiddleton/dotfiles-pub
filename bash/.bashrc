# ---------- Modified default Ubuntu bashrc ---------- #
#
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# for default ubuntu .bashrc see https://gist.github.com/marioBonales/1637696

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
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

# colored GCC/G++ warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more standard ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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


# ---------- Debian distro specific ----------- #

# set debian_chroot
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# ---------------- Custom ------------------- #


# open manpages in nvim
viman () {
    man $1 | nvim -
}
# alias to still get autocomplete
alias man='viman' 
# it would be better to have it as a separate command but can't get autocompletion working
# complete -F _man viman

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
        printf '#include <stdio.h>\n#include <stdlib.h>\n\nint main()\n{\n    return 0;\n}' \
            > main.c
        nvim $HOME/sandbox/main.c
    elif [ $1 = "cpp" ]; then
        printf '#!/bin/bash\ng++ main.cpp\n./a.out\n' > scripts/run.sh
        printf '#include <iostream>\n\nint main()\n{\n    return 0;\n}' \
            > main.cpp
        nvim $HOME/sandbox/main.cpp
    elif [ $1 = "python" ]; then
        python3 -m venv env
        source ./env/bin/activate
        if [[ -z "$VIRTUAL_ENV" ]]; then
            echo "Failed to source venv"
        else
            pip install jupyter
            printf '{\n"cells": [],\n"metadata": {},\n"nbformat": 4,\n"nbformat_minor": 2\n}\n' \
                > main.ipynb
            jupyter notebook
        fi
    elif [ $1 = "rust" ]; then
        printf '#!/bin/bash\ncargo run' > scripts/run.sh
        cargo init 
        nvim $HOME/sandbox/src/main.rs
    fi
}


mkvim()
{
    dir=$(pwd)
    if [[ $1 == "--gui" ]]; then
        obsidian &
        obsidian_pid=$!
    else
        pid=$(ps -ax | grep "Xvfb :10 -ac$" | grep "^   [0-9]* " -o)
        if [[ $pid ]]; then
            read -e -p "Xvfb process already running on :10, kill it? (y/n) " choice
            if [[ "$choice" == [Yy]* ]]; then
                kill $pid
            else
                echo "Exiting..."
                cd $dir
                exit 1
            fi
        fi
        firefox &>/dev/null & # can't seem to kill this process during cleanup
        Xvfb :10 -ac &>/dev/null & 
        xvfb_pid=$!
        DISPLAY=":10" obsidian &>/dev/null & 
        obsidian_pid=$!
    fi
    cd ~/Documents/Vault 
    ./Files/AutoMd/generate_mds.sh
    sleep 3 
    last_file="$HOME/.local/state/mkvim/.last_file_opened"
    mkdir -p $(dirname $last_file) && touch $last_file
    nvim "$(cat $last_file)" -u "$HOME/.config/nvim/mkinit.lua" 
    kill $xvfb_pid
    kill $obsidian_pid
    nvim --headless -u NONE -i ~/.local/state/nvim/shada/main.shada -c"echo v:oldfiles[0] | qall!" 2> $last_file
    cd $dir
}

# bind f5 to run a script
# the '; echo' is required to remove a partial line break indicator
bind '"\e[15~":"./scripts/run.sh; echo\n"'

. "$HOME/.cargo/env"

alias ..='cd ..'

PS1='\[\033[01;32m\]\h\[\033[00m\]:\w\$ '



