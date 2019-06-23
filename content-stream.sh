#!/bin/sh

exec ffmpeg \
	-v error \
	-i http://bassdrive.radioca.st \
	-af "highpass=f=300, lowpass=f=3400" \
	-ar 8000 \
	-ac 1 \
	-ab 64k \
	-f alaw -
