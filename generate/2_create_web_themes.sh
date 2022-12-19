#!/usr/bin/env sh

DARK_SOURCE_PATH="./sources/web/dark/"
LIGHT_SOURCE_PATH="./sources/web/light/"

DARK_DESTINATION_PATH="./themes/dark/"
LIGHT_DESTINATION_PATH="./themes/light/"

echo "Creating dark \"web\" themes"

find "$DARK_SOURCE_PATH" -type f -exec sh -c '
	FLAVOR=$1
	DESTINATION_PATH=$2
	shift 2  # remove the first 2 arguments

	for f do
		./_web_to_theme.sh "$f" \
			"$FLAVOR" "$DESTINATION_PATH"
	done' find-sh \
	"dark" "$DARK_DESTINATION_PATH" {} +

echo "Creating light \"web\" themes"

find "$LIGHT_SOURCE_PATH" -type f -exec sh -c '
	FLAVOR=$1
	DESTINATION_PATH=$2
	shift 2  # remove the first 2 arguments

	for f do
		./_web_to_theme.sh "$f" \
			"$FLAVOR" "$DESTINATION_PATH"
	done' find-sh \
	"light" "$LIGHT_DESTINATION_PATH" {} +
