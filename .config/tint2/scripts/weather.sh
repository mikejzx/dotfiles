#!/bin/bash
#
# weather.sh
#
# Weather on panel.
#

ICO_PATH=~/.config/tint2/scripts/icons/w
icon="weather-none-available.svg"

# Retrieve weather data.
WEATHER_FILE_PATH=~/.cache/getweather-data.json
if [[ ! -f $WEATHER_FILE_PATH ]]; then
	# File doesn't exist
	firstline="No data..."
	echo "$ICO_PATH/$icon"
	echo "${firstline:0:12}"
	exit -1
fi
weather="$(cat $WEATHER_FILE_PATH)"

# Make sure we got a 200 code
if [[ -z "$(echo "$weather" | grep -F '"cod": 200')" ]]; then
	# No data
	firstline="No data..."
	echo "$ICO_PATH/$icon"
	echo "${firstline:0:12}"
else
	# Get temperature
	temp=$(echo "$weather" | grep -E '"temp"\: .*,' | awk '{print ($2 - 272.15)}' | sed 's/\..*//g')

	# Get wind speed.
	wind=$(echo "$weather" | grep -E '"speed"\: .*,' | awk '{print ($2 * 3.6)}' | sed 's/\..*//g')

	# Create lines
	firstline="T: ${temp}°C"
	secondline="WS: ${wind:-0} km/h"

	# Get weather icon
	wth=$(echo "$weather" | grep -E '"main"\: \".*\",' | awk '{print $2}' | sed -e 's/\"//g')
	wth=${wth%,}
	if [[ "$wth" == "Clear" ]]; then
		icon="weather-clear.svg"

	elif [[ "$wth" == "Clouds" ]]; then
		icon="weather-clouds.svg"

	elif [[ "$wth" == "Rain" ]]; then
		icon="weather-showers.svg"

	elif [[ "$wth" == "Overcast" ]]; then
		icon="weather-overcast.svg"

	elif [[ "$wth" == "Storms" ]]; then
		icon="weather-storm.svg"
	fi

	# Output
	echo "$ICO_PATH/$icon"
	echo "${firstline:0:12}"
	echo "${secondline:0:12}"
fi
