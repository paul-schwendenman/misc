# Set a colorful and informative prompt
if [[ $- == *i* ]]; then
  # Basic prompt with username, hostname, and working dir
  PS1='[\u@\h \W]\$ '

  # Append Git branch if inside a Git repo
  if command -v git >/dev/null 2>&1; then
    parse_git_branch() {
      git branch 2>/dev/null | sed -n '/\* /s///p'
    }
    PS1='[\u@\h \W$(parse_git_branch)]\$ '
  fi
fi
