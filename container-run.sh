#!/bin/bash

args=$@

if [ -z $BASEQ3_DIR ]
then
  echo "Please set env var BASEQ3_DIR to the path of the baseq3 folder in your legitimate copy of Quake III Arena. Exitting."
  exit 1
fi

docker run --rm -it \
           --gpus=all \
           -e DISPLAY -e XAUTHORITY -v /tmp/.X11-unix:/tmp/.X11-unix \
           --device /dev/snd \
           -v $(pwd):/q3io-src --workdir /q3io-src $args \
           -v $BASEQ3_DIR:/root/.q3a/baseq3 \
           q3io:$(git branch | grep \* | sed 's/\* *//g') 
