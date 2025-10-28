# betterman.fish - Better man with colorized output

# Detect bat command (bat or batcat)
if command -v bat &>/dev/null
    set -g __betterman_bat_cmd bat
else if command -v batcat &>/dev/null
    set -g __betterman_bat_cmd batcat
else
    echo "betterman.fish: 'bat' command not found. Install bat for colorized output." >&2
end

# Set MANPAGER only if bat is available and MANPAGER is not set
if test -n "$__betterman_bat_cmd"; and not set -q MANPAGER
    # sh -c: to interpret pipe
    # col -bx: to remove backspace sequences (^H)
    set -gx MANPAGER "sh -c 'col -bx | bat --language=man --style=plain --paging=always'"
end

# Set MANROFFOPT for better compatibility
if not set -q MANROFFOPT
    set -gx MANROFFOPT -c
end
