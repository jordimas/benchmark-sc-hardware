#!/bin/bash

[ -z "$DEVICE" ] && DEVICE="cpu"
[ -z "$COMPUTE_TYPE" ] && COMPUTE_TYPE="int8"
[ -z "$DEVICE_INDEX" ] && DEVICE_INDEX="0"

cd /srv/

if [ "$TASK" = "translation" ]; then
    export CTRANSLATE_INTER_THREADS=6 # Prod default
    cmd="/usr/bin/time -f %e model_to_txt -m cat-eng -f cat.txt -t eng.txt"
else
    cmd="/usr/bin/time -f %e whisper-ctranslate2 15GdH1.mp3  --model medium --threads 8 --device $DEVICE --compute_type $COMPUTE_TYPE --device_index $DEVICE_INDEX"
fi

eval $cmd
echo Executed: $cmd
