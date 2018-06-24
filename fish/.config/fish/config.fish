if [ -f $HOME/password-store/src/completion/pass.fish-completion ]
    . $HOME/password-store/src/completion/pass.fish-completion
end

if test -d $HOME/.local/bin
    set PATH $HOME/.local/bin/ $PATH
end

if test -d $HOME/.bin
    set PATH $HOME/.bin/ $PATH
end

function qrcode
     xclip -o selection clipboard | qrencode --size 10 -o - | feh -x --title QR -g +200+200 -
end
