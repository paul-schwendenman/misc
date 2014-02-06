# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

HISTSIZE=1500
HISTFILESIZE=1500

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

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

if [ -f "/usr/bin/acpi" ] ; then
    ACPI="`acpi -b | awk -F ' ' '{print $4}'`"
else
    ACPI=
fi


if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}\n\[\033[m\][$$:$PPID - \j:\!\[\033[m\]]\[\033[0;36m\] \T \\[\033[m\][\[\033[0;32m\]\u@\H\[\033[m\]:\[\033[0;35m ${ACPI} \033[0;34m\]+${SHLVL}\[\033[m\]] \[\033[m\]\w\[\033[m\]  \n$ "
	#"${debian_chroot:+($debian_chroot)}\n\[\033[0;30m\][$$:$PPID - \j:\!\[\033[0;30m\]]\[\033[0;36m\] \T \\[\033[0;30m\][\[\033[0;32m\]\u@\H\[\033[0;30m\]:\[\033[0;35m `acpi -b | awk -F ' ' '{print $4}'` \033[0;34m\]+${SHLVL}\[\033[0;30m\]] \[\033[0;30m\]\w\[\033[0;30m\]  \n$ " #0;32m
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1="${debian_chroot:+($debian_chroot)}\n[$$:$PPID - \j:\!] [\T \[\\u@\H: ${ACPI} +${SHLVL}] \w  \n$ "
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

alias joe='joe -keepup'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# startx if the first ttyl on a given uname
#if [ ${SHLVL} = 1 ] && [ $(tty) = /dev/tty1 ] && ! [ `uname -n` = "paul-ubuntu" ] ; then
#    startx
#fi

#if [ ${SHLVL} = 1 ] && ! [ -z `echo $(tty) | grep tty` ]; then fi
#if [ ${SHLVL} = 2 ] && [ ${TERM} = "screen" ] ; then fi
#WHITE="${debian_chroot:+($debian_chroot)}\n\[\033[0;37m\][$$:$PPID - \j:\!\[\033[0;37m\]]\[\033[0;36m\] \T \\[\033[0;37m\][\[\033[0;32m\]\u@\H\[\033[0;37m\]:\[\033[0;35m `acpi -b | awk -F ' ' '{print $4}'` \033[0;34m\]+${SHLVL}\[\033[0;37m\]] \[\033[0;37m\]\w\[\033[0;37m\]  \n$ " #0;32m
#BLACK="${debian_chroot:+($debian_chroot)}\n\[\033[0;30m\][$$:$PPID - \j:\!\[\033[0;30m\]]\[\033[0;36m\] \T \\[\033[0;30m\][\[\033[0;32m\]\u@\H\[\033[0;30m\]:\[\033[0;35m `acpi -b | awk -F ' ' '{print $4}'` \033[0;34m\]+${SHLVL}\[\033[0;30m\]] \[\033[0;30m\]\w\[\033[0;30m\]  \n$ " #0;32m
#CLR="${debian_chroot:+($debian_chroot)}\n\[\033[m\][$$:$PPID - \j:\!\[\033[m\]]\[\033[0;36m\] \T \\[\033[m\][\[\033[0;32m\]\u@\H\[\033[m\]:\[\033[0;35m `acpi -b | awk -F ' ' '{print $4}'` \033[0;34m\]+${SHLVL}\[\033[m\]] \[\033[m\]\w\[\033[m\]  \n$ " #0;32m

#export PYTHONPATH=${HOME}/.lib/python

# Set joe as editor
if [ -f /usr/bin/joe ]; then
	export EDITOR=/usr/bin/joe
elif [ -f /usr/local/bin/joe ]; then
	export EDITOR=/usr/local/bin/joe
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.bin" ] ; then
    PATH="$HOME/.bin:$PATH"
fi