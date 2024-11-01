#!/usr/bin/env bash
# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting
source "$HOME/.config/sketchybar/secrets.sh"
TEMP=`curl -s "https://api.weather.gov/gridpoints/FFC/${LOCATION}/forecast/hourly" | jq -r '.properties.periods[0].temperature'`
ICON=`curl -s "https://api.weather.gov/gridpoints/FFC/${LOCATION}/forecast/hourly" | jq -r '.properties.periods[0].shortForecast'`
SKY=`curl -s "https://api.weather.gov/gridpoints/FFC/${LOCATION}/forecast/hourly" | jq -r '.properties.periods[0].isDaytime'`

echo $TEMP
echo $ICON
echo $SKY

weather_icon_map() {
	shopt -s extglob
	# check if first argument is true or false to determine whether day or night
	# then check if second argument wildcard contains a string for determining which icon to show
	# if no match, return default icon
	if [ "$1" = "true" ]; then # Daytime
		case $2 in
		*Snow*)
			icon_result=""
			;;
		*Rain* | *Showers*)
			icon_result=""
			;;
		*"Partly Sunny"* | *"Partly Cloudy"*)
			icon_result=""
			;;
		*Sunny* | *Clear* )
			icon_result=""
			;;
		*Cloudy*)
			icon_result=""
			;;
        *Haze*)
            icon_result=""
            ;;
		*)
			icon_result=""
			;;
		esac
	else
		case $2 in # Night
		*Snow*)
			icon_result=""
			;;
		*Rain* | *Showers*)
			icon_result=""
			;;
		*Clear*)
			icon_result=""
			;;
		*Cloudy*)
			icon_result=""
			;;
		*Fog*)
			icon_result=""
			;;
        *Haze*)
            icon_result="󰖑"
            ;;
		*)
			icon_result=""
			;;
		esac
	fi
	echo $icon_result
}

BARICON=`weather_icon_map "$SKY" "$ICON"`

sketchybar --set $NAME label="${TEMP}°F" \
        --set $NAME icon="${BARICON}" \
        --set $NAME icon.color="0xff8bd5ca" \
	   --set $NAME click_script="/usr/bin/open /System/Applications/Weather.app"
