#!/usr/bin/env bash

PROGNAME="$(basename "$0")"

usage () {
	echo ""
	echo "$PROGNAME: usage: $PROGNAME [-f file | -i]"
	echo ""
	return
}


interactive=
filename=

while [[ -n "$1" ]]; do
	case "$1" in
		-f | --file)		shift
					filename="$1"							
					;;
		-i | --interactive)	interactive=1
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
