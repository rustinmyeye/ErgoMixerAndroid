#!/bin/sh

## Download .jar
echo "Retrieving Ergo Mixer release.."
wget -O mixer.jar https://github.com/ergoMixer/ergoMixBack/releases/download/4.3.0/ergoMixer-4.3.0.jar
clear

## create default config file
curl https://raw.githubusercontent.com/ergoMixer/ergoMixBack/master/mixer/reference.conf > default.comf

## Start node 
echo "Starting the mixer..."
tmux new-session -d -s mixer_session 'java -jar -D"config.file"=default.conf mixer.jar'
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