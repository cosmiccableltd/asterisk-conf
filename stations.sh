#!/bin/sh

get_sname() {
	case "$1" in
		248)
			echo "Casbah Faraday"
			;;
		272)
			echo "Content Receiver"
			;;
		273)
			echo "Quaeken Quatsche"
			;;
		221)
			echo "Amtsleitung\t"
			;;
		232)
			echo "Backyard Bells"
			;;
		234)
			echo "Wuestenfoen\t"
			;;
		231)
			echo "Digame Baile"
			;;
		241)
			echo "Raeuberleitung"
			;;
		250)
			echo "Mokka Brigade"
			;;
		255)
			echo "Nebenstelle Neuland"
			;;
		224)
			echo "Casino Connection"
			;;
		226)
			echo "IT Container"
			;;
		223)
			echo "Cosmic Wireless"
			;;
#		227)
#			echo "Dubstation WoZi"
#			;;
#		228)
#			echo "Dubstation SchlafZi"
#			;;
#		229)
#			echo "Dubstation Garten"
#			;;
		213)
			echo "Feldpostanschluss"
			;;
		225)
			echo "Central Station"
			;;
		233)
			echo "Fire Wire\t"
			;;
		242)
			echo "Nordstern Network"
			;;
		251)
			echo "Radstelzen\t"
			;;
		269)
			echo "Rumstelzen\t"
			;;
		211)
			echo "Antenne Oase"
			;;
		253)
			echo "Fer a Cable\t"
			;;
		216)
			echo "Konsum Klient"
			;;
		247)
			echo "Seefunk\t"
			;;
		*)
			echo "unknown\t"
			;;
	esac
}

if [ x"$1" = x"-r" ]; then
	ONLY_REGISTERED=1
else
	ONLY_REGISTERED=0
fi

asterisk -rx "sip show peers" | grep "^10../.*$" | while read station ip _r _s _b1 _b2 d; do
	sid="$(echo $station | cut -d'/' -f1)"
	snum="$(asterisk -rx "database get id $sid" | cut -d':' -f2 | tr -d " ")"
	if [ "${snum:0:4}" = "Data" ]; then
		if [ $ONLY_REGISTERED -eq 1 ]; then
			continue
		fi
		sname="unregistered\t"
	else
		snum="2$snum"
		sname="$snum $(get_sname $snum)"
	fi
	echo -e "$sname\t(SIP:$sid IP:$ip)\t$d";
done | sort
