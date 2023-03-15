#!/bin/sh

# Setup firewall
echo "Setting up firewall..."
sleep 2

echo "#!/bin/sh
# ensure ufw is installed
apk add ip6tables iptables ufw --quiet

ufw default deny incoming
ufw default deny outgoing
ufw limit SSH         
ufw allow out 123/udp # allow outgoing NTP (Network Time Protocol)

# The following instructions will allow apk to work:
ufw allow out DNS     # allow outgoing DNS
ufw allow out 80/tcp  # allow outgoing HTTP traffic
ufw allow in to 127.0.0.1
ufw allow out to 127.0.0.1

ufw enable     # enable the firewall
rc-update add ufw    # add UFW init scripts

lbu add /usr/lib/ufw
lbu commit" > firewall.sh

chmod +x firewall.sh

tmux new-session -d -s firewall_session 'sh firewall.sh'

## Download .jar
echo "Retrieving latest Ergo Mixer release.."
wget -O mixer.jar https://github.com/ergoMixer/ergoMixBack/releases/download/4.3.0/ergoMixer-4.3.0.jar
clear

## Start node 
echo "Starting the mixer..."
tmux new-session -d -s mixer_session 'java -jar mixer.jar'
sleep 10

#messages and blender :)
spinner="/|\\-/|\\-"
spinner_pos=0                                          
                                                       
while true; do                                         
clear                                                 
  echo "Ergo Mixer is mixing!"
  
  echo "Please visit http://127.0.0.1:9000/dashboard to start using Ergo Mixer!"
  
  echo "A backup can be made in the dashboard under "Configuration""
  
  echo -e "\033[31mPlease consider making a backup!!!\033[0m"
  
  echo "   _____.-._____"                              
  echo "  '-------------'"                             
  echo "  |    (o)(0)   |"                             
  echo "  |  o.(.--).o  |"                             
  echo "  \  O\` ) : \`o  /"                           
  echo "   | o.( _).O  |"                              
  echo "    \O\` \`- 'o /"                             
  echo -n "     |   ${spinner:spinner_pos++:1}    |"   
  if [ $spinner_pos -eq ${#spinner} ]; then            
    spinner_pos=0                                      
  fi                                                   
  echo ""                                              
  echo "     \_______/"                                
  echo "  .'==========='."                             
  echo " / o o o o o o o \\ erg "                      
  echo "'-----------------'"                           
  sleep 0.5                                           
done                                                     