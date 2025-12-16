# Create a backup of a file
function backup -d "Create a backup of a file with timestamp"
    if test -f $argv[1]
        cp $argv[1] $argv[1].(date +%Y%m%d-%H%M%S).bak
        echo "Backup created: $argv[1].(date +%Y%m%d-%H%M%S).bak"
    else
        echo "'$argv[1]' is not a valid file"
        return 1
    end
end
