#!/bin/sh

# Setup firewall
echo "Setting ip firewall..."
sleep 2

# Enable ufw firewall
ufw enable

# Set default policies
ufw default deny incoming
ufw default allow outgoing

# Allow loopback traffic
#ufw allow in on lo
#ufw allow out on lo

clear

## Download .jar
echo "Retrieving latest Ergo Mixer release.."
wget -O mixer.jar https://github.com/ergoMixer/ergoMixBack/releases/download/4.3.0/ergoMixer-4.3.0.jar
clear

## Start node
echo "Starting the Mixer..."

echo "Please visit https://0.0.0.0.9000/dashboard to start using Ergo Mixer!" 

tmux new-session -d -s mixer_session 'java -jar mixer.jar'

spinner="/|\\-/|\\-"
while :
do
    for i in $(seq 0 7); do
        echo -ne "\r${spinner:$i:1}"
        sleep 0.1
    done
done
