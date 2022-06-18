#  __                _ _____ _             
# |  |   ___ ___ ___| |     |_|___ ___ ___ ©️
# |  |__| . |  _| .'| | | | | |   | -_|  _|
# |_____|___|___|__,|_|_|_|_|_|_|_|___|_|  
# https://localminer.me , https://github.com/localminer

#!/bin/bash

echo "  __                _ _____ _                "
echo " |  |   ___ ___ ___| |     |_|___ ___ ___ ©️  "
echo " |  |__| . |  _| .'| | | | | |   | -_|  _|   "
echo " |_____|___|___|__,|_|_|_|_|_|_|_|___|_|     "
echo " https://localminer.me , https://github.com/localminer "
echo " "
echo "LocalMiner: Host Locally!"
echo "============================"
echo "Website : https://localminer.me"
echo "Github  : https://github.com/localminer"


##### USER CONFIGURATIONS #####
# set to true if you want to use Paper, update Paper_SERVER below to the correct version if necessary
# leave as false if using vanilla, update VANILLA_SERVER below if necessary
read -p "Using Paper (yes/[no])? " USE_Paper
USE_Paper=${USE_Paper:-no}

# set to false if you have your own port-forwarding setup
# leave as true to forward local ip to online through ngrok so other people can join
read -p "Using ngrok ([yes]/no)?" USE_NGROK
USE_NGROK=${USE_NGROK:-yes}

if [ "$USE_NGROK" = "yes" ] ; then
  read -p "ngrok authtoken (REQUIRED see https://dashboard.ngrok.com/get-started/your-authtoken): " AUTHTOKEN
  read -p "ngrok region ([us]/eu/ap/au): " NGROK_REGION
  NGROK_REGION=${NGROK_REGION:-us}
fi

# Paper server URL (1.18.1), update as necessary
DEF_Paper_INSTALLER="https://api.papermc.io/v2/projects/paper/versions/1.18.2/builds/379/downloads/paper-1.18.2-379.jar"
DEF_VANILLA_SERVER="https://launcher.mojang.com/v1/objects/125e5adf40c659fd3bce3e66e67a16bb49ecc1b9/server.jar"
if [ "$USE_Paper" = "yes" ] ; then
  read -p "Custom Paper installer (leave blank for default: $DEF_Paper_INSTALLER)? " Paper_SERVER
  Paper_SERVER=${Paper_SERVER:-$DEF_Paper_INSTALLER}
else
  read -p "Custom vanilla server (leave blank for default: $DEF_VANILLA_SERVER)? " VANILLA_SERVER
  VANILLA_SERVER=${VANILLA_SERVER:-$DEF_VANILLA_SERVER}
fi

# don't need to edit this
EXEC_SERVER_NAME="minecraft_server.jar"

##### MINECRAFT/NGROK INSTALLATION #####

pkg install openjdk-17 zip unzip -y

# minecraft server download and setup
echo "STATUS: setting up Minecraft Server"
mkdir LocalMiner
cd LocalMiner
echo "eula=true" > eula.txt
if [ "$USE_Paper" = "yes" ] ; then
  wget $Paper_SERVER
  installer_jar=$(echo $Paper_SERVER | rev | cut -d '/' -f 1 | rev)
  # exec_jar=$(echo $installer_jar | sed -e 's/-installer//g')
  java -jar $installer_jar --installServer
  # mv $exec_jar $EXEC_SERVER_NAME
  # rm $installer_jar
  echo "cd LocalMiner && java -Xmx1G -jar paper-1.18.2-379.jar nogui" > ../m.sh
else
  wget -O $EXEC_SERVER_NAME $VANILLA_SERVER
  echo "cd LocalMiner && java -Xmx1G -jar ${EXEC_SERVER_NAME} nogui" > ../m.sh
fi
chmod +x ../m.sh

# ngrok download and setup
if [ "$USE_NGROK" = "yes" ] ; then
  echo "STATUS: setting up ngrok"
  cd ..
  wget -O ngrok.zip https://bin.equinox.io/a/e93TBaoFgZw/ngrok-2.2.8-linux-arm.zip && unzip ngrok.zip && chmod +x ngrok
  echo "./ngrok tcp --region=$NGROK_REGION 25565" > n.sh
  chmod +x n.sh
  ./ngrok authtoken $AUTHTOKEN
fi

echo " "
echo "-------------------------------------------------"
echo "STATUS: installation complete!"
echo "Run ./m.sh here to start minecraft server, "
echo "open a new session by swiping on the left, "
echo "and run ./n.sh there to start ngrok"
echo "-------------------------------------------------"
echo "L O C A L  M I N E R | H O S T  L O C A L L Y !"
echo "                            Script By Healer-op"
echo "-------------------------------------------------"
echo " "
