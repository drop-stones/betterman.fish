function man --description "Better man with colorized --help fallback"
    # If bat is not available or no arguments, use standard man
    if set -q __betterman_bat_cmd || test (count $argv) -eq 0
        command man $argv
        return
    end

    set -l cmd $argv[1]

    # Check if man page exists
    if command man -w $argv &>/dev/null
        command man $argv
        return
    end

    # Check if command exists
    if not command -v $cmd &>/dev/null
        echo "No manual entry for $cmd" >&2
        return 16
    end

    # Fallback to --help with bat
    $cmd --help 2>&1 | $__betterman_bat_cmd --language=help --style=plain
end
