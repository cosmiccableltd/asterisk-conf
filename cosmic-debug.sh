#!/bin/sh

checkresults() {
	while read line
	do
	case ${line:0:4} in
	"200 " ) echo $line >&2
	         return;;
	"510 " ) echo $line >&2
	         return;;	
	"520 " ) echo $line >&2
	         return;;
	*      ) echo $line >&2;;	#keep on reading those Invlid command
					#command syntax until "520 End ..."
	esac
	done
}

stations_down() {
	/etc/asterisk/stations.sh -r | sed -n 's/^.\(..\).*UNKNOWN.*$/\1/p' | 
	grep \
		-e '^212' \
		-e '^213' \
		-e '^216' \
		-e '^224' \
		-e '^225' \
		-e '^231' \
		-e '^232' \
		-e '^233' \
		-e '^234' \
		-e '^241' \
		-e '^242' \
		-e '^247' \
		-e '^248' \
		-e '^251' \
		-e '^253' \
		-e '^255' \
		-e '^272' \
		-e '^273'
}

stations_missing() {
	/etc/asterisk/stations.sh | sed -E -n 's/^2(..).*$/\1/p' | sort > /tmp/registered-stations
	sort /etc/asterisk/defined-extensions.txt > /tmp/defined-stations
	comm -1 -3 /tmp/registered-stations /tmp/defined-stations | sed 's/^/2/'
}


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
