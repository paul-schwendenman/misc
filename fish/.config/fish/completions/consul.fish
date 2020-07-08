
function __complete_consul
    set -lx COMP_LINE (string join ' ' (commandline -o))
    test (commandline -ct) = ""
    and set COMP_LINE "$COMP_LINE "
    /usr/local/bin/consul
end
complete -c consul -a "(__complete_consul)"

