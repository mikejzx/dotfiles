#!/bin/bash
#
# cpuup.sh
#
# CPU and uptime on panel.
#

mem="$(free | head -n 2 | tail -n 1 | awk '{print ($3/$2)*100}' | sed 's/\..*//g')"

upsec="$(cat /proc/uptime | sed 's/\..*//g')"
uph=$((upsec / 3600))
upm=$(((upsec / 60) % 60))

printf 'Mem: %s%%\nUp: %01d:%02d' "$mem" "$uph" "$upm"
