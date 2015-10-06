if [ -f $HOME/password-store/src/completion/pass.fish-completion ]
    . $HOME/password-store/src/completion/pass.fish-completion
end

if [ -f $HOME/.local/bin ]
    set PATH $HOME/local/bin/ $PATH
end
