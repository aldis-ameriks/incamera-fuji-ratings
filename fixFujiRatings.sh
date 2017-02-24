#!/bin/bash

# This script is used to fix fuji in-camera ratings to be readable by adobe.
# It only works when reading fuji rating from JPG files (and not RAF), so
# shoot JPG or JPG+RAF to use this script.

# Usage:
# 1. Move it to /usr/local/bin to include it in path
# 2. Open terminal
# 3. Execute "fixFujiRatings <path to directory with images>"

# WARNING. This is experimental, use it on your own risk.

# Has been tested only on X-T2 with 1.10 firmware.

shopt -s nocaseglob
if [ "$#" -lt 1 ]; then
    PATH_TO_DIRECTORY=$PWD
else
	PATH_TO_DIRECTORY=$1
fi

for FUJI_JPG in "$PATH_TO_DIRECTORY"/*.JPG; do
	echo "Updating: $FUJI_JPG"
	if [[ $FUJI_JPG =~ (.*).JPG ]]; then
		FILE_WITHOUT_EXTENSION=${BASH_REMATCH[1]}
	fi


	FUJI_RATING_OUTPUT=$(exiftool -rating "$FUJI_JPG")
	RATING="${FUJI_RATING_OUTPUT: -1}"

	# Adobe does not work well with the default fuji way of writing ratings to
	# JPGs, overwrite the same rating.
	exiftool -overwrite_original -rating=$RATING "$FILE_WITHOUT_EXTENSION".JPG

	FUJI_RAF=$FILE_WITHOUT_EXTENSION.RAF
	FUJI_XMP=$FILE_WITHOUT_EXTENSION.xmp

	if [ -f "$FUJI_RAF" ]; then
		if [ -f "$FUJI_XMP" ]; then
			exiftool -overwrite_original -rating=$RATING "$FUJI_XMP"
		else
			exiftool -xmp -b "$FUJI_RAF" > "$FUJI_XMP"
			exiftool -overwrite_original -rating=$RATING "$FUJI_XMP"
		fi
	fi
done
