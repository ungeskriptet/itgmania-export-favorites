#!/usr/bin/env bash

help () {
  cat <<EOF
Export ITGmania favorites

Options:
-f | --favorites <path to favorites.txt> (Default: ~/.itgmania/Save/LocalProfiles/00000000/favorites.txt)
-s | --songs <path to song folder> (Default: ~/.itgmania/Songs)
-o | --out <path to output folder> (Default: itgmania-export)
-v | --verbose	Show copy progress
-h | --help	Show help and exit
EOF
}

is_empty() {
	test -e "$1/"* 2>/dev/null
	case "$?" in
		1) return 0 ;;
		*) return 1 ;;
	esac
}

# Defaults
favorites="$HOME/.itgmania/Save/LocalProfiles/00000000/favorites.txt"
songs="$HOME/.itgmania/Songs"
out="itgmania-export"
verbose=0

while [ $# -gt 0 ]; do
	case "$1" in
		--favorites|-f) favorites="$2"; shift 2 ;;
		--songs|-s) songs="$2"; shift 2 ;;
		--out|-o) out="$2"; shift 2 ;;
		--verbose|-v) verbose=1; shift 1 ;;
		--help|-h) help; exit ;;
		*) break ;;
	esac
done

for i in "$favorites" "$songs"; do
	if [ ! -f "$i" ] && [ ! -d "$i" ]; then
		echo "No such file or directory: $i" 1>&2
		exit 1
	fi
done

if [ -e "$out" ] && ! is_empty "$out"; then
	echo "$out already exists and is not empty" 1>&2
	exit 1
fi
mkdir -p $out

echo "Exporting favorites. This might take a while..."

while IFS="" read line; do
	if [ "$(dirname -- "$line")" = "." ]; then
		continue
	fi
	songpack="$(dirname "$line")"
	if [ -d "$songs/$line" ] && is_empty "$out/$line"; then
		[ $verbose -eq 1 ] && echo "Copying $line"
		mkdir -p "$out/$songpack"
		cp -r "$songs/$line" "$out/$songpack"
	elif [ ! -d "$songs/$line" ]; then
		echo "Skipping: No such song in songs folder: $line"
	elif ! is_empty "$out/$line"; then
		echo "Skipping: Song already exists in export folder: $line"
	fi
done < "$favorites"

echo "Done! You can find the export in $out"
