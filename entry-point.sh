#!/bin/bash

[ -z "$DEVICE" ] && DEVICE="cuda"
[ -z "$COMPUTE_TYPE" ] && COMPUTE_TYPE="int8"
[ -z "$DEVICE_INDEX" ] && DEVICE_INDEX="0"

cd /srv/

cmd="/usr/bin/time -f %e whisper-ctranslate2 inaguracio2011.mp3 --word_timestamps True --model medium --threads 8 --device $DEVICE --compute_type $COMPUTE_TYPE --device_index $DEVICE_INDEX --hf_token $HF_TOKEN"

eval $cmd
echo Executed: $cmd
head inaguracio2011.srt
#bash

