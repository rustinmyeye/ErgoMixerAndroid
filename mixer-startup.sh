#!/bin/bash

## Download .jar
echo "- Retrieving latest Ergo Mixer release.."
wget -O mixer.jar https://github.com/ergoMixer/ergoMixBack/releases/download/4.3.0/ergoMixer-4.3.0.jar
clear

## Start node
echo "Starting the Mixer..."

echo "Please visit https://0.0.0.0.9000/dashboard to start using Ergo Mixer!" 

tmux new-session -d -s mixer_session 'java -jar mixer.jar'
