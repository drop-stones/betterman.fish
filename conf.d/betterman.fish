# betterman.fish - Better man with colorized output

# Check if bat is available
if not command -v bat &>/dev/null
    echo "betterman.fish: 'bat' command not found. Install bat for colorized output." >&2
    echo "  Arch Linux: pacman -S bat" >&2
    echo "  Ubuntu/Debian: apt install bat" >&2
    echo "  macOS: brew install bat" >&2
    set -g __betterman_bat_available 0
else
    set -g __betterman_bat_available 1
end

# Set MANPAGER only if not already set and bat is available
if test $__betterman_bat_available -eq 1 && not set -q MANPAGER
    set -gx MANPAGER "sh -c 'col -bx | bat --language=man --style=plain --paging=always'"
end

# Set MANROFFOPT for better compatibility
if not set -q MANROFFOPT
    set -gx MANROFFOPT -c
end
