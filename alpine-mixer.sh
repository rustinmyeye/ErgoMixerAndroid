#!/bin/bash

#download things
echo "Downloading stuff... please wait :)"
apk update --quiet
apk add openjdk11 python3 iptables ip6tables curl --quiet
clear

#create startup script
cd ..
cd etc
cd profile.d 
curl https://raw.githubusercontent.com/rustinmyeye/ErgoMixerAndroid/main/mixer-startup.sh >> mixer.sh
chmod +x mixer.sh
clear

##create firewall

# Flush existing rules
iptables -F
ip6tables -F

# Allow loopback traffic
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Block incoming traffic on port 9000
iptables -A INPUT -p tcp --dport 9000 -j DROP

# Block all other incoming traffic
iptables -P INPUT DROP

# Save rules to persist across reboots
iptables-save > /etc/iptables/rules.v4

# Repeat for IPv6
ip6tables -A INPUT -i lo -j ACCEPT
ip6tables -A OUTPUT -o lo -j ACCEPT
ip6tables -A INPUT -p tcp --dport 9000 -j DROP
ip6tables -P INPUT DROP
ip6tables-save > /etc/iptables/rules.v6

clear
