#!/bin/sh

cd "$(dirname "$0")"
. ./cosmic-debug-functions.sh

OFFLINE=0

echo "EXEC Playback \"/mnt/sda3/content/announce/timeline-hello\""
checkresults

for station in $(stations_down) $(stations_missing); do
	echo "EXEC Playback \"/mnt/sda3/content/announce/callerid-${station}\""
	checkresults
	OFFLINE=1
done

if [ $OFFLINE -eq 0 ]; then
	echo "EXEC Playback \"/mnt/sda3/content/content/nocheinanruf\""
	checkresults
fi
