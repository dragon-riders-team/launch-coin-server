#!/bin/bash


AC_NAME=`$(dirname $0)/config.py ac_name`
PARAMS=`$(dirname $0)/config.py`

docker run \
  --name $AC_NAME \
  --net=host \
  --rm -d \
  --mount "src=zcash-params,dst=/home/komodo/.zcash-params" \
  --mount "src=$AC_NAME,dst=/home/komodo/.komodo" \
  kmdplatform/komodod:lite \
  -bind=0.0.0.0 \
  -rpcbind=127.0.0.1 \
  -rpcallowip=0.0.0.0/0 \
  $PARAMS \
  -whitelist=127.0.0.1 \
  -printtoconsole=1 \
  -server=1 \
  -txindex=1 \
  -addressindex=1 \
  -timestampindex=1 \
  -spentindex=1 \
  -uacomment='bitcore' \
  -showmetrics=0 \
  -zmqpubrawtx='tcp://127.0.0.1:8332' \
  -zmqpubhashblock='tcp://127.0.0.1:8332' \
  -reindex

