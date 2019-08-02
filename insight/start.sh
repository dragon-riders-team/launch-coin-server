#!/bin/bash

if [ -n "$1" ]; then
  AC_NAME=$1
else
  echo "Error: coin name is required!"
  exit
fi

if [ -n "$2" ]; then
  AC_UI=$2
else
  AC_UI="https://github.com/DeckerSU/insight-ui-komodo"
fi
echo && echo "Using UI url: $AC_UI"

JSON=`$(dirname $0)/gen-coin-json.py $AC_NAME`
echo && echo "Using configuration:"
echo $JSON && echo

docker run \
  --rm \
  -d -ti \
  -e JSON="$JSON" \
  -e AC_UI=$AC_UI \
  --net=host \
  --name=insight \
  kmdplatform/insight:sapling

