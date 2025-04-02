# ~/.bashrc: executed by bash(1) for non-login shells.

# Exit early if not interactive
[[ $- != *i* ]] && return

# Set history behavior
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=5000
HISTFILESIZE=5000
shopt -s checkwinsize

# Load all config snippets from ~/.bashrc.d/
for file in ~/.bashrc.d/*.sh; do
  [ -r "$file" ] && source "$file"
done
