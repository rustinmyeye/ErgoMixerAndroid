#!/bin/sh

#firewall setup
echo "Setting up firewall..."
sleep 2

echo "#!/bin/sh
iptables -P INPUT DROP
ip6tables -P INPUT DROP
iptables -A INPUT -i lo -j ACCEPT
ip6tables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -i lo -p tcp --dport 9000 -j ACCEPT
ip6tables -A INPUT -i lo -p tcp --dport 9000 -j ACCEPT
iptables -A INPUT -j DROP
ip6tables -A INPUT -j DROP
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6
rc-service iptables start
rc-service ip6tables start" > firewall.sh

chmod +x firewall.sh && sh firewall.sh

## Download .jar
echo "Retrieving Ergo Mixer release.."
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