
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s`
fi

export PATH="/usr/local/opt/node@8/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


if [ -f /usr/local/opt/asdf/libexec/asdf.sh ]; then
    # . /usr/local/opt/asdf/asdf.sh
    . /usr/local/opt/asdf/libexec/asdf.sh
fi

if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
