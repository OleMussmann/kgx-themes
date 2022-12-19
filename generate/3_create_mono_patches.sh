#!/usr/bin/env sh

DARK_THEME_PATH="./themes/dark/"
LIGHT_THEME_PATH="./themes/light/"
DARK_PATCH_PATH="../patches/dark/"
LIGHT_PATCH_PATH="../patches/light/"

FOREGRND_ALPHA=1.0
BACKGRND_ALPHAS=$'0.95\n1.00'

##
FOREGRND_A=1.0
BACKGRND_A=1.00
##

MONO_TEMPLATE="./templates/0001-mono-theme-template.patch"

FLAVOR=""

for BACKGRND_ALPHA in $BACKGRND_ALPHAS; do

	echo "Creating light theme patches with alpha=$BACKGRND_ALPHA"

	find "$LIGHT_THEME_PATH" -type f -exec sh -c '
		MONO_TEMPLATE=$1
		FLAVOR=$2
		LIGHT_PATCH_PATH=$3
		FOREGRND_ALPHA=$4
		BACKGRND_ALPHA=$5
		shift 5  # remove the first 5 arguments

		for THEME_FILE do
			PATCH_FILENAME="$(
			sed -e "s/\.theme$/\.alpha_$BACKGRND_ALPHA\.patch/" \
				<<<"$(basename "$THEME_FILE")")"
			./_print_patch_text.sh "$THEME_FILE" \
				"$MONO_TEMPLATE" "$FLAVOR" \
				"$FOREGRND_ALPHA" "$BACKGRND_ALPHA" > \
				"$LIGHT_PATCH_PATH"/"$PATCH_FILENAME"
		done' find-sh \
		"$MONO_TEMPLATE" "$FLAVOR" "$LIGHT_PATCH_PATH" \
		"$FOREGRND_ALPHA" "$BACKGRND_ALPHA" {} +

	echo "Creating dark theme patches with alpha=$BACKGRND_ALPHA"

	find "$DARK_THEME_PATH" -type f -exec sh -c '
		MONO_TEMPLATE=$1
		FLAVOR=$2
		DARK_PATCH_PATH=$3
		FOREGRND_ALPHA=$4
		BACKGRND_ALPHA=$5
		shift 5  # remove the first 5 arguments

		for THEME_FILE do
			PATCH_FILENAME="$(
			sed -e "s/\.theme$/\.alpha_$BACKGRND_ALPHA\.patch/" \
				<<<"$(basename "$THEME_FILE")")"
			./_print_patch_text.sh "$THEME_FILE" \
				"$MONO_TEMPLATE" "$FLAVOR" \
				"$FOREGRND_ALPHA" "$BACKGRND_ALPHA" > \
				"$DARK_PATCH_PATH"/"$PATCH_FILENAME"
		done' find-sh \
		"$MONO_TEMPLATE" "$FLAVOR" "$DARK_PATCH_PATH" \
		"$FOREGRND_ALPHA" "$BACKGRND_ALPHA" {} +
done
