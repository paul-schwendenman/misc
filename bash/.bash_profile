# Homebrew must be initialized FIRST (before .profile/.bashrc which may use Homebrew-installed tools)
# Apple Silicon path first, then Intel
if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Source asdf (uses $HOMEBREW_PREFIX set above)
if [ -f "$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh" ]; then
  . "$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh"
fi

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

[[ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]] && . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
