#!/bin/bash

#try login
apt update -y
proot-distro login alpine-ergo
clear

#download proot-distro
apt install proot-distro -y
clear

#download alpine-ergo.sh setup plugin for proot-distro
cd ..
cd usr
cd etc
cd proot-distro
curl https://raw.githubusercontent.com/rustinmyeye/ErgoNodeAndroid/master/alpine-ergo.sh >> alpine-ergo.sh
clear

#install alpine linux with alpine-ergo plugin with proot-distro
proot-distro install alpine-ergo
clear

#run alpine linux and start node setup
proot-distro login alpine-ergo --  bash <(curl -s https://raw.githubusercontent.com/rustinmyeye/ErgoMixerAndroid/main/alpine-mixer.sh)
clear
proot-distro login alpine-ergo 
