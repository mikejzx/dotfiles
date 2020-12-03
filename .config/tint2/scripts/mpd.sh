#!/bin/bash

#
# mpd.sh
#
# Displays current MPD song in panel.
#

ICO_PATH=~/.config/tint2/scripts/icons
icon="media-playback-start.svg"

mpdstat="$(mpc status 2>&1)"

# Check for error.
if [[ -n "$(echo "$mpdstat" | grep -Fi "MPD error")" ]]; then
	echo "$ICO_PATH/$icon"
	echo "Not playing..."
	exit 0
fi

# Show pause button if we are playing
if [[ -z "$(echo "$mpdstat" | grep -Fi '[paused]')" ]]; then
	# Playing, show pause button
	icon="media-playback-pause.svg"
fi

# Get song artist and title. We need to escape some strings since
# we are using the rich formatting
song=$(mpc -f "<b>%artist%</b> — %title%" | head -n 1 | sed 's|&|&amp;|g')

echo "$ICO_PATH/$icon"
echo "$song"
