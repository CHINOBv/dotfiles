# Show weather
function weather -d "Show weather for a city (default: auto-detect)"
    set -l city $argv[1]
    if test -z "$city"
        curl -s "wttr.in?format=3"
    else
        curl -s "wttr.in/$city?format=3"
    end
end
