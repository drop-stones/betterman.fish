function man --description "Better man with colorized --help fallback"
    if test "$__betterman_bat_available" = 0 || test (count $argv) -eq 0
        command man
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

    # Fallback to --help
    $cmd --help 2>&1 | bat --language=help --style=plain
end
