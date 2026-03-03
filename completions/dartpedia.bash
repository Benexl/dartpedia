_dartpedia_completion() {
	local cur prev opts
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD - 1]}"

	local commands="search cache"
	local global_opts="--version -v --help -h --theme -t --log --loglevel -l"

	case "${prev}" in
	search)
		COMPREPLY=($(compgen -W "--lang -l --help -h" -- "${cur}"))
		return 0
		;;
	cache)
		COMPREPLY=($(compgen -W "clear list --help -h" -- "${cur}"))
		return 0
		;;
	--theme | -t)
		COMPREPLY=($(compgen -W "arcticPetrol electricSolarized nordicFrost wikipediaClassic" -- "${cur}"))
		return 0
		;;
	--loglevel | -l)
		COMPREPLY=($(compgen -W "all fine debug info warning error" -- "${cur}"))
		return 0
		;;
	esac

	if [[ ${cur} == -* ]]; then
		COMPREPLY=($(compgen -W "${global_opts}" -- "${cur}"))
		return 0
	fi

	COMPREPLY=($(compgen -W "${commands}" -- "${cur}"))
}
complete -F _dartpedia_completion dartpedia
