#!/usr/bin/env sh

SOURCE_FILE="$1"
FLAVOR="$2"  # light/dark
DESTINATION_PATH="$3"

KEYS="NAME=
SOURCE=\"https://github.com/stayradiated/terminal.sexy\"
LICENSE=\"MIT\"
COLOR_00=
COLOR_01=
COLOR_02=
COLOR_03=
COLOR_04=
COLOR_05=
COLOR_06=
COLOR_07=
COLOR_08=
COLOR_09=
COLOR_10=
COLOR_11=
COLOR_12=
COLOR_13=
COLOR_14=
COLOR_15=
FOREGRND=
BACKGRND="

create_theme_text () {
	SOURCE_FILE="$1"
	THEME_NAME="$2"
	COLOR_CODES="$(sed -n 's/.*#\([a-fA-F0-9]\{6\}\).*/\1/p' \
		"$SOURCE_FILE")"
	VALS="\"$THEME_NAME\"\n\n\n$COLOR_CODES"
	paste <(echo "$KEYS") <(printf "$VALS") --delimiters ''
}

SOURCE_FILENAME="$(basename "$SOURCE_FILE")"
THEME_NAME="$(sed -e "s/\.json$//" <<<"$SOURCE_FILENAME")"
SOURCE_FILENAME_SANITIZED="$(sed -e "s/ /_/g" <<<"$SOURCE_FILENAME")"
OUTPUT_FILENAME="$(sed \
	-e "s/[\._-]"$FLAVOR"\.json/\.json/" \
	-e "s/\.json$/\.theme/" \
	<<<"$SOURCE_FILENAME_SANITIZED")"
echo "$(create_theme_text \
	"$SOURCE_FILE" "$THEME_NAME" )" \
	> "$DESTINATION_PATH/$OUTPUT_FILENAME"

