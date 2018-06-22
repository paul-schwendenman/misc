if [ -f $HOME/password-store/src/completion/pass.fish-completion ]
    . $HOME/password-store/src/completion/pass.fish-completion
end

if test -d $HOME/.local/bin
    set PATH $HOME/.local/bin/ $PATH
end

if test -d $HOME/.bin
    set PATH $HOME/.bin/ $PATH
end

function start_ssh
    if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]
        eval (ssh-agent)
        echo 'SSH_AUTH_SOCK='"$SSH_AUTH_SOCK"
        trap "kill $SSH_AGENT_PID" 0
    end
    ssh-add ~/.ssh/server_rsa
end

function qrcode
     xclip -o selection clipboard | qrencode --size 10 -o - | feh -x --title QR -g +200+200 -
end
