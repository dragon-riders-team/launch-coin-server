#!/bin/bash

if [ -n "$1" ]; then
  AC_NAME=$1
else
  echo "Error: coin name is required!"
  exit
fi

CONFIG_FILE="/var/lib/docker/volumes/$AC_NAME/_data/$AC_NAME/$AC_NAME.conf"
echo "Trying configuration file: $CONFIG_FILE ..."
source $CONFIG_FILE && echo "Configuration file loaded." || ERROR=1
if [ "$ERROR" = "1" ]; then
  echo "Error: configuration file not found!"
  exit
fi
echo "rpcuser: $rpcuser"

docker run --rm -d \
  --name electrum_$AC_NAME \
  --net host \
  --mount "src=electrum_$AC_NAME,dst=/data" \
  -e DAEMON_URL=http://$rpcuser:$rpcpassword@127.0.0.1:$rpcport \
  -e COIN=Komodo \
  -e SERVICES="rpc://127.0.0.1:8000,tcp://0.0.0.0:50001" \
  lukechilds/electrumx

