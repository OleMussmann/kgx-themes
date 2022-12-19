#!/usr/bin/env sh

# ./_create_patch.sh <input_theme_file> <input_patch_template> <flavor>

INPUT_THEME_FILE=$1
INPUT_PATCH_TEMPLATE=$2
FLAVOR=$3  # "DARK_", "LIGHT_", ""
FOREGRND_A=$4
BACKGRND_A=$5

source $INPUT_THEME_FILE

hex_to_number() {
	HEX=$1
	printf "%d %d %d\n" 0x${HEX:0:2} 0x${HEX:2:2} 0x${HEX:4:2} | \
		awk '{printf "%.3f %.3f %.3f", $1/255, $2/255, $3/255}'
}

read -r FOREGRND_R FOREGRND_G FOREGRND_B < <(hex_to_number "$FOREGRND")
read -r BACKGRND_R BACKGRND_G BACKGRND_B < <(hex_to_number "$BACKGRND")

sed \
	-e "s/#${FLAVOR}COLOR_00#/$COLOR_00/" \
	-e "s/#${FLAVOR}COLOR_01#/$COLOR_01/" \
	-e "s/#${FLAVOR}COLOR_02#/$COLOR_02/" \
	-e "s/#${FLAVOR}COLOR_03#/$COLOR_03/" \
	-e "s/#${FLAVOR}COLOR_04#/$COLOR_04/" \
	-e "s/#${FLAVOR}COLOR_05#/$COLOR_05/" \
	-e "s/#${FLAVOR}COLOR_06#/$COLOR_06/" \
	-e "s/#${FLAVOR}COLOR_07#/$COLOR_07/" \
	-e "s/#${FLAVOR}COLOR_08#/$COLOR_08/" \
	-e "s/#${FLAVOR}COLOR_09#/$COLOR_09/" \
	-e "s/#${FLAVOR}COLOR_10#/$COLOR_10/" \
	-e "s/#${FLAVOR}COLOR_11#/$COLOR_11/" \
	-e "s/#${FLAVOR}COLOR_12#/$COLOR_12/" \
	-e "s/#${FLAVOR}COLOR_13#/$COLOR_13/" \
	-e "s/#${FLAVOR}COLOR_14#/$COLOR_14/" \
	-e "s/#${FLAVOR}COLOR_15#/$COLOR_15/" \
	-e "s/#${FLAVOR}FOREGRND_R#/$FOREGRND_R/g" \
	-e "s/#${FLAVOR}FOREGRND_G#/$FOREGRND_G/g" \
	-e "s/#${FLAVOR}FOREGRND_B#/$FOREGRND_B/g" \
	-e "s/#${FLAVOR}FOREGRND_A#/$FOREGRND_A/g" \
	-e "s/#${FLAVOR}BACKGRND_R#/$BACKGRND_R/g" \
	-e "s/#${FLAVOR}BACKGRND_G#/$BACKGRND_G/g" \
	-e "s/#${FLAVOR}BACKGRND_B#/$BACKGRND_B/g" \
	-e "s/#${FLAVOR}BACKGRND_A#/$BACKGRND_A/g" \
	$INPUT_PATCH_TEMPLATE
