#!/bin/sh

#
# getweather.sh
# Gets weather data and writes to ~/.cache/getweather-data.json
#

WD="$HOME/src/scripts"
lat=$(cat "$WD/.getweather-latlon" | awk '{print $1}')
lon=$(cat "$WD/.getweather-latlon" | awk '{print $2}')
appid=$(cat "$WD/.getweather-appid")

# Get weather data from OpenWeatherMap and pipe into output file.
curl -s "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&APPID=$appid" | jq > $HOME/.cache/getweather-data.json

# Update counter
GWCOUNT=$WD/.getweather-counter-cur
old=$(cat $GWCOUNT)
new=$(($old+1))
echo "$new" > $GWCOUNT
