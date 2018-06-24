
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

GPG_TTY=$(/usr/bin/tty)
SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export GPG_TTY SSH_AUTH_SOCK
gpgconf --launch gpg-agent
