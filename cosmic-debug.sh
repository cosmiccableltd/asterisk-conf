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
#	echo "11 33"
#	return
	stations.sh -r | sed -n 's/^.\(..\).*UNKNOWN.*$/\1/p' | 
	grep \
		-e '^211' \
		-e '^213' \
		-e '^216' \
		-e '^221' \
		-e '^222' \
		-e '^224' \
		-e '^225' \
		-e '^231' \
		-e '^232' \
		-e '^233' \
		-e '^234' \
		-e '^241' \
		-e '^242' \
		-e '^251' \
		-e '^253' \
		-e '^255' \
		-e '^269' 
		
}

OFFLINE=0

echo "EXEC Playback \"/mnt/sda3/content/announce/timeline-hello\""
checkresults

for station in $(stations_down); do
	echo "EXEC Playback \"/mnt/sda3/content/announce/callerid-${station}\""
	checkresults
	OFFLINE=1
done

if [ $OFFLINE -eq 0 ]; then
	echo "EXEC Playback \"/mnt/sda3/content/content/nocheinanruf\""
	checkresults
fi
