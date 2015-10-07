if [ -f $HOME/password-store/src/completion/pass.fish-completion ]
    . $HOME/password-store/src/completion/pass.fish-completion
end

if [ -f $HOME/.local/bin ]
    set PATH $HOME/local/bin/ $PATH
end

function start_ssh
    if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]
        eval (ssh-agent)
        echo 'SSH_AUTH_SOCK='"$SSH_AUTH_SOCK"
        trap "kill $SSH_AGENT_PID" 0
    end
    ssh-add ~/.ssh/server_rsa
end