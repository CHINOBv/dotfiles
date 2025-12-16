# Go up N directories
function up -d "Go up N directories (default 1)"
    set -l count $argv[1]
    if test -z "$count"
        set count 1
    end
    
    set -l path ""
    for i in (seq $count)
        set path "$path../"
    end
    
    cd $path
end
