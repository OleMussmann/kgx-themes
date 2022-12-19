#!/usr/bin/env sh

THEME_FILE="$1"
FOREGROUND_ALPHA="1.00"
BACKGROUND_ALPHA="$2"

MONO_TEMPLATE="./generate/templates/0001-mono-theme-template.patch"

PATCH_FILENAME="$(sed -e "s/\.theme$/\.alpha_$BACKGROUND_ALPHA\.patch/" \
	<<<"$(basename "$THEME_FILE")")"

echo "Creating patch file \""$PATCH_FILENAME\"""
./generate/_print_patch_text.sh "$THEME_FILE" "$MONO_TEMPLATE" "" \
	"$FOREGROUND_ALPHA" "$BACKGROUND_ALPHA" > "$PATCH_FILENAME"
