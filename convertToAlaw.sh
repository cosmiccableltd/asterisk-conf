#! /usr/bin/env bash


for file in $@;
do
	TMP_FILE="$(mktemp).wav"
	ALAW_FILE="$file.alaw"

	ffmpeg -i $file -f wav - | cat > ${TMP_FILE}
	sox -V ${TMP_FILE} -c 1 -t al -r 8000 - | cat > ${ALAW_FILE}
done

