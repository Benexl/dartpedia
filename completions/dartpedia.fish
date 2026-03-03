complete -c dartpedia -f

# Global options
complete -c dartpedia -s v -l version -d 'Show version information'
complete -c dartpedia -s h -l help -d 'Show help information'
complete -c dartpedia -s t -l theme -r -a 'arcticPetrol electricSolarized nordicFrost wikipediaClassic' -d 'Choose a theme'
complete -c dartpedia -l log -d 'Enable logging'
complete -c dartpedia -s l -l loglevel -r -a 'all fine debug info warning error' -d 'Set log level'

# Search command
complete -c dartpedia -n "__fish_use_subcommand" -a search -d 'Search for stuff on wikipedia'
complete -c dartpedia -n "__fish_seen_subcommand_from search" -s l -l lang -r -d 'Language edition to search in'
complete -c dartpedia -n "__fish_seen_subcommand_from search" -s h -l help -d 'Show help information'

# Cache command
complete -c dartpedia -n "__fish_use_subcommand" -a cache -d 'Manage the dartpedia cache'
complete -c dartpedia -n "__fish_seen_subcommand_from cache" -s h -l help -d 'Show help information'
complete -c dartpedia -n "__fish_seen_subcommand_from cache" -a clear -d 'Clear all cached content'
complete -c dartpedia -n "__fish_seen_subcommand_from cache" -a list -d 'List cached articles'
