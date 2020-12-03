#!/bin/bash

#
# launch-browser.sh
#
# Launches browser (currently Brave) from mutt.
#

mv "$1" "$1.html"
brave-browser-nightly "$1.html" &>/dev/null 2>&1
