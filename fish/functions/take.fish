# Clone a repo and cd into it, or mkcd
function take -d "Create directory and cd into it, or clone repo and cd"
    if string match -q "*.git" $argv[1]; or string match -q "*github.com*" $argv[1]; or string match -q "*gitlab.com*" $argv[1]
        git clone $argv[1]
        cd (basename $argv[1] .git)
    else
        mkdir -p $argv[1] && cd $argv[1]
    end
end
