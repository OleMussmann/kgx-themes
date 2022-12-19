#!/usr/bin/env sh

THEME_FILE_LIGHT="$1"
FOREGROUND_ALPHA_LIGHT="1.00"
BACKGROUND_ALPHA_LIGHT="$2"
THEME_FILE_DARK="$3"
FOREGROUND_ALPHA_DARK="1.00"
BACKGROUND_ALPHA_DARK="$4"

DUAL_TEMPLATE="./generate/templates/0001-dual-theme-template.patch"

LIGHT_SNIPPET="$(sed -e "s/\.theme$/\.alpha_$BACKGROUND_ALPHA_LIGHT/" \
	<<<"$(basename "$THEME_FILE_LIGHT")")"

DARK_SNIPPET="$(sed -e "s/\.theme$/\.alpha_$BACKGROUND_ALPHA_DARK/" \
	<<<"$(basename "$THEME_FILE_DARK")")"

PATCH_FILENAME="$LIGHT_SNIPPET.$DARK_SNIPPET.patch"

LIGHT_APPLIED="$(./generate/_print_patch_text.sh "$THEME_FILE_LIGHT" \
	"$DUAL_TEMPLATE" "LIGHT_" "$FOREGROUND_ALPHA_LIGHT" \
	"$BACKGROUND_ALPHA_LIGHT")"

echo "Creating patch file \""$PATCH_FILENAME\"""

./generate/_print_patch_text.sh "$THEME_FILE_DARK" \
	<(echo "$LIGHT_APPLIED") "DARK_" "$FOREGROUND_ALPHA_DARK" \
	"$BACKGROUND_ALPHA_DARK" > "$PATCH_FILENAME"
