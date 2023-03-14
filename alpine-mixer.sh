#!/bin/bash

#download things
apk add openjdk11 python3 curl

#create startup script
cd ..
cd etc
cd profile.d 
curl https://github.com/rustinmyeye/ErgoMixerAndroid/raw/main/mixer-startup.sh >> mixer.sh
chmod +x mixer.sh
