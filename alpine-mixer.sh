#!/bin/bash

#download things
echo "Downloading stuff... please wait :)"
apk add openjdk11 python3 curl --quiet

#create startup script
cd ..
cd etc
cd profile.d 
curl https://github.com/rustinmyeye/ErgoMixerAndroid/raw/main/mixer-startup.sh >> mixer.sh
chmod +x mixer.sh
