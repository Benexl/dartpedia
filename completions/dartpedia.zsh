#compdef dartpedia

_dartpedia() {
    local line

    _arguments -C \
        '(-v --version)'{-v,--version}'[Show version information]' \
        '(-h --help)'{-h,--help}'[Show help information]' \
        '(-t --theme)'{-t,--theme}'[Choose a theme]:theme:(arcticPetrol electricSolarized nordicFrost wikipediaClassic)' \
        '--log[Enable logging]' \
        '(-l --loglevel)'{-l,--loglevel}'[Set log level]:loglevel:(all fine debug info warning error)' \
        "1: :((search\:'Search for stuff on wikipedia' cache\:'Manage the dartpedia cache'))" \
        "*::arg:->args"

    case $line[1] in
        search)
            _arguments \
                '(-l --lang)'{-l,--lang}'[Language edition to search in]:lang:' \
                '(-h --help)'{-h,--help}'[Show help information]'
        ;;
        cache)
            _arguments \
                '(-h --help)'{-h,--help}'[Show help information]' \
                "1: :((clear\:'Clear all cached content' list\:'List cached articles'))"
        ;;
    esac
}

_dartpedia "$@"
