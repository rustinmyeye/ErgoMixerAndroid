#!/bin/sh

## Download .jar
echo "Retrieving Ergo Mixer release.."
wget -O mixer.jar https://github.com/ergoMixer/ergoMixBack/releases/download/4.3.0/ergoMixer-4.3.0.jar
clear

## create default config file
echo "play.http.secret.key = "QCY?tAnfk?aZ?iwrNwnxIlR6CTf:G3gf:90Latabg@5241AB`R5W:1uDFN];Ik@n"
http.port = 9000
play.server.http.port = 9000

play: {
  http {
        filters="filters.CorsFilters",
        fileMimeTypes = ${play.http.fileMimeTypes} """
                 wasm=application/wasm
                """
       }
  filters {
    hosts {
      # Allow requests to example.com, its subdomains, and localhost:9000.
      allowed = ["localhost", "127.0.0.1"]
    }
    cors {
      pathPrefixes = ["/"]
      allowedOrigins = null,
      allowedHttpMethods = ["GET", "POST"]
      allowedHttpHeaders = null
    }
  }
}

networkType = "mainnet"
explorerBackend = "https://api.ergoplatform.com"
explorerFrontend = "https://explorer.ergoplatform.com"
nodes = ["213.239.193.208:9053", "159.65.11.55:9053", "165.227.26.175:9053", "159.89.116.15:9053"]

// database info, will be saved in home directory. this is where all secrets are saved. make sure its safe.
database = {
  // whether to prune done mixes
  // this is mostly for performance reasons, we recommend you to enable the pruning
  prune = false
  // number of confirmations to wait for the withdrawn transaction, before pruning a mix
  // so for example, if set to 720, mixes that have been withdrawn and confirmed for 720 blocks (around 1 day) will be prunned
  pruneAfter = 720

  user = "changeme"
  pass = "changeme"
}

jobInterval = 180 // interval between mixing boxes, no need to be less than 2 min! around 4 mins seems to be smoothest.
statisticJobsInterval = 3600 // period between updating statistics. Doesn't need to be small!
numConfirmation = 3 // increasing this will cause slower mixes but more confidence about avoiding rare cases (forks). better to avoid setting it less than 2!
maxOutputs = 10 // maximum number of outputs in one txs.
maxInputs = 6 // maximum number of inputs in one txs.

// default fees
fees = {
  // fee used for each kind of transaction, these are different because tx size of each kind is different!
  // to preserve fee/byte ratio the same for all txs
  // don't change this unless there is an announcement by mixer owners
  distributeTx = 1500000 // creating mix boxes
  startTx = 2500000 // buying token and start mixing
  halfTx = 1252000
  fullTx = 1628000
  halfTokenTx = 1287000
  fullTokenTx = 1666000
  ageusd = 5000000
}

proxy = { // all trafics will go through this proxy if set (except address derivation from node)
  url = "" // 127.0.0.1
  port = 0 // 9050
  protocol = "SOCKS" // HTTP or SOCKS
}

mixOnlyAsBob = false // if true, your mix boxes will never be converted to half-box. Do not change this if you don't know what you are doing
stopMixingWhenReachedThreshold = true // if true, will mark the mix as complete when it reaches the predefined mix rounds.

db.default.driver=org.h2.Driver
db.default.url="jdbc:h2:~/ergoMixer/database"
db.default.user=${?database.user}
db.default.password=${?database.pass}
play.evolutions.autoApply = true
play.evolutions.db.default.autoApply=true
play.evolutions.db.default.autoApplyDowns=true" > config.conf

## Start node 
echo "Starting the mixer..."
tmux new-session -d -s mixer_session 'java -jar -D"config.file"=config.conf mixer.jar'
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