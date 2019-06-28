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
		-e '^12' \
		-e '^13' \
		-e '^16' \
		-e '^24' \
		-e '^25' \
		-e '^31' \
		-e '^32' \
		-e '^33' \
		-e '^34' \
		-e '^41' \
		-e '^42' \
		-e '^47' \
		-e '^48' \
		-e '^51' \
		-e '^53' \
		-e '^55' \
		-e '^72' \
		-e '^73'
}

stations_missing() {
	/etc/asterisk/stations.sh | sed -E -n 's/^2(..).*$/\1/p' | sort > /tmp/registered-stations
	sort /etc/asterisk/defined-extensions.txt > /tmp/defined-stations
	comm -1 -3 /tmp/registered-stations /tmp/defined-stations
}



