#!/usr/bin/env bash

prg_name=$(basename "${0}")

usage () {
	printf "\nUsage: %s [-f file | -i]\n\n" "${prg_name}"
	return
}


interactive=
filename=

# Перебор параметров
while [[ -n "$1" ]]; do
	case "$1" in
		-f | --file)        shift
					        filename="$1"
					        echo "${filename}"
					        ;;
		-i | --interactive)	interactive=1
		                    printf "flag interactive = %s\n" "${interactive}"
					        ;;
		-h | --help)		usage
					        exit
					        ;;
		*)			usage >&2
					exit 1
					;;
	esac
	shift
done
