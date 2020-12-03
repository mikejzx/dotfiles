#!/bin/bash
#
# clock.sh
#
# A custom clock. This displays *ordinal*
# day numbers. Yes, I know, a lot of work
# for such as small detail lol
#

# Get ordinal day
dayint=$(date +"%-d")
daysuf="th"
if (( $dayint < 11 )) || (( $dayint > 13 )); then
	# Select suffix
	case $(( $dayint % 10 )) in
		1) daysuf="st" ;;
		2) daysuf="nd" ;;
		3) daysuf="rd" ;;
		4) daysuf="th" ;;
	esac
fi
dayord="$dayint$daysuf"

echo " $(date +"%a, %b $dayord %Y    ")$(bash-fuzzy-clock)"
