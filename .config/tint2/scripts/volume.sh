#!/bin/bash

#
# volume.sh
#
# Prints volume information.

#vol=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
vol="$(pamixer --get-volume)"

ICO_PATH=~/.config/tint2/scripts/icons/v
if [[ "$vol" -eq 0 ]]; then
	icon="audio-volume-muted.svg"
elif [[ "$vol" -lt 35 ]]; then
	icon="audio-volume-low.svg"
elif [[ "$vol" -lt 75 ]]; then
	icon="audio-volume-medium.svg"
else
	icon="audio-volume-high.svg"
fi

echo "$ICO_PATH/$icon"
echo "$vol "
