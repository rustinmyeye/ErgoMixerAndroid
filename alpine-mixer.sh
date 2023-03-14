#!/bin/bash

#download things
echo "Downloading stuff... please wait :)"
apk update --quiet
apk add openjdk11 tmux python3 iptables ip6tables wget curl --quiet
clear

#create startup script
cd ..
cd etc
cd profile.d 
curl https://raw.githubusercontent.com/rustinmyeye/ErgoMixerAndroid/main/mixer-startup.sh >> mixer.sh
chmod +x mixer.sh
clear