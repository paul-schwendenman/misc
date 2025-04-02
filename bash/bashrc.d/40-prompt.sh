# Determine chroot name for prompt
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Check for color support
case "$TERM" in
    xterm-color) color_prompt=yes ;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if command -v tput >/dev/null && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Git prompt support
if [ -f ~/.git-prompt.sh ]; then
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWUPSTREAM="auto"
    source ~/.git-prompt.sh
else
    __git_ps1 () { echo -n " (unknown)"; }
fi

# Kubernetes context prompt
if command -v kubectl >/dev/null 2>&1; then
  function __kube_ps1 {
    local config_files="${KUBECONFIG:-$HOME/.kube/config}"
    local context=""
    IFS=':' read -ra paths <<< "$config_files"
    for path in "${paths[@]}"; do
      if [[ -f "$path" ]]; then
        context=$(grep '^current-context:' "$path" | sed 's/current-context: \(.*\)/\1/')
        [[ -n "$context" ]] && break
      fi
    done

    local namespace=""
    if [[ -n "$context" ]]; then
      namespace=$(kubectl config view -o=jsonpath="{.contexts[?(@.name == '${context}')].context.namespace}" 2>/dev/null)
      echo -e "(${context}:${namespace:-default})"
    fi
  }
else
  function __kube_ps1 { echo -n ""; }
fi

# Define prompt themes
WHITE="${debian_chroot:+($debian_chroot)}\n\[\033[0;37m\][\$\$:$$PPID - \j:\!\[\033[0;37m\]]\[\033[0;36m\] \T \[\033[0;37m\][\[\033[0;32m\]\u@\H\[\033[0;37m\]:\[\033[0;35m\] +${SHLVL} \[\033[0;37m\]] \[\033[0;33m\]\$(__git_ps1) \$(__kube_ps1) \[\033[0;37m\]\w\[\033[0;37m\]\n\$ "

BLACK="${debian_chroot:+($debian_chroot)}\n\[\033[0;30m\][\$\$:$$PPID - \j:\!\[\033[0;30m\]]\[\033[0;36m\] \T \[\033[0;30m\][\[\033[0;32m\]\u@\H\[\033[0;30m\]:\[\033[0;35m\] +${SHLVL} \[\033[0;30m\]] \[\033[0;33m\]\$(__git_ps1) \$(__kube_ps1) \[\033[0;30m\]\w\[\033[0;30m\]\n\$ "

CLR="${debian_chroot:+($debian_chroot)}\n\[\033[m\][\$\$:$$PPID - \j:\!\[\033[m\]]\[\033[0;36m\] \T \[\033[m\][\[\033[0;32m\]\u@\H\[\033[m\]:\[\033[0;35m\] +${SHLVL} \[\033[m\]] \[\033[0;33m\]\$(__git_ps1) \$(__kube_ps1) \[\033[m\]\w\[\033[m\]\n\$ "

DEFAULT="${debian_chroot:+($debian_chroot)}\n\[\033[m\][\$\$:$$PPID - \j:\!\[\033[m\]]\[\033[0;36m\] \T \[\033[m\][\[\033[0;32m\]\u@\H\[\033[m\]: \[\033[0;34m\]+${SHLVL}\[\033[m\]] \[\033[0;35m\]\$?\[\033[0;33m\]\$(__git_ps1) \$(__kube_ps1) \[\033[m\]\w\[\033[m\]\n\$ "

# Apply the selected prompt theme
case "$PROMPT_THEME" in
  WHITE)   PS1="$WHITE" ;;
  BLACK)   PS1="$BLACK" ;;
  CLR)     PS1="$CLR" ;;
  *)       PS1="$DEFAULT" ;;
esac

# Set terminal title for xterm
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
esac

unset color_prompt force_color_prompt
