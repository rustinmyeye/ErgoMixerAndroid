#!/bin/bash

##create firewall
echo "Setting up the firewall"
sleep 2

# Flush existing rules
iptables -F
ip6tables -F

# Allow loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow incoming to port 9000 from loopback
iptables -A INPUT -i lo -p tcp --dport 9000 -j ACCEPT

# Block all other incoming traffic
iptables -P INPUT DROP

# Save rules to persist across reboots
iptables-save > /etc/iptables/rules.v4

# Repeat for IPv6
ip6tables -A INPUT -i lo -j ACCEPT
ip6tables -A OUTPUT -o lo -j ACCEPT
ip6tables -A INPUT -i lo -p tcp --dport 9000 -j ACCEPT
ip6tables -P INPUT DROP
ip6tables-save > /etc/iptables/rules.v6

clear

## Download .jar
echo "- Retrieving latest Ergo Mixer release.."
wget -O mixer.jar https://github.com/ergoMixer/ergoMixBack/releases/download/4.3.0/ergoMixer-4.3.0.jar
clear

## Start node
echo "Starting the Mixer..."

echo "Please visit https://0.0.0.0.9000/dashboard to start using Ergo Mixer!" 

tmux new-session -d -s mixer_session 'java -jar mixer.jar'
