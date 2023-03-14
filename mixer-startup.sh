#!/bin/bash

## Download .jar
echo "- Retrieving latest Ergo Mixer release.."
LATEST_MIXER_RELEASE=$(curl -s "https://api.github.com/repos/ergoMixer/ergoMixBack/releases/latest" | awk -F '"' '/tag_name/{print $4}')
LATEST_MIXER_RELEASE_NUMBERS=$(echo ${LATEST_MIXER_RELEASE} | cut -c 2-)
MIXER_DOWNLOAD_URL=https://github.com/ergoMixer/ergoMixBack/releases/download/${LATEST_ERGO_RELEASE}/ergoMixer-${LATEST_ERGO_RELEASE_NUMBERS}.jar
echo "- Downloading Latest known Ergo Mixer release: ${LATEST_MIXER_RELEASE}."
curl --silent -L ${MIXER_DOWNLOAD_URL} --output mixer.jar

## Start node
echo "Starting the Mixer..."

echo "Please visit https://0.0.0.0.9000/dashboard to start using Ergo Mixer!" 

java -jar mixer.jar
