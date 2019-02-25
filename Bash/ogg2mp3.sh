#!/bin/bash

echo "The script convert mp3->ogg or ogg->mp3.";
echo "The script takes one parameter: ";
echo "[mp3ogg] - converting mp3->ogg";
echo "[oggmp3] - converting ogg->mp3";


if [ "$1" = "" ]; then
    echo "";
    echo "Argument does not exist!!!";
    exit 1;
fi


if [ "$1" = "mp3ogg" ]; then
    for file in *.mp3; do
         avconv -i "$file" "`echo ${file%.mp3}.ogg`";
    done
    exit 0;
fi

if [ "$1" = "oggmp3" ]; then
    for file in *.ogg; do
         avconv -i "$file" -acodec libmp3lame "`echo ${file%.ogg}.mp3`";
    done
    exit 0;
fi

exit 1

