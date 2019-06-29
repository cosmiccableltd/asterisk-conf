#!/bin/sh

cd "$(dirname "$0")"
. ./cosmic-debug-functions.sh

OFFLINE=0

for station in $(stations_down) $(stations_missing); do
	echo "$station seems to be down."
	OFFLINE=1
done

if [ $OFFLINE -eq 0 ]; then
	echo "All stations are working fine. Go and get wasted!"
fi
