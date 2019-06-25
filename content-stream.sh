#!/bin/sh

#
# Sidechain compression example.
# Combines multiple compressors to achieve ratio of 60
#
# SIDECHAIN="sidechaincompress=threshold=0.003:ratio=20:attack=10:release=9000:knee=1:detection=peak"; ffmpeg -y -stream_loop -1 -i music.wav -i talk.wav -filter_complex '[1:a]asplit=4[talk1][talk2][talk3][talk4];[0:a][talk1]'$SIDECHAIN'[pause_a];[pause_a][talk2]'$SIDECHAIN'[pause_b];[pause_b][talk3]'$SIDECHAIN'[pause];[pause][talk4]amerge[final]' -map '[final]' -v trace -ac 1 final.wav && mpv final.wav


exec ffmpeg \
	-v error \
	-i http://bassdrive.radioca.st \
	-af "highpass=f=300, lowpass=f=3400" \
	-ar 8000 \
	-ac 1 \
	-ab 64k \
	-f alaw -
