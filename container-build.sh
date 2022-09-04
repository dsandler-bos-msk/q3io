#!/bin/bash

docker build --target dev -t q3io:$(git branch | grep \* | sed 's/\* *//g') .
