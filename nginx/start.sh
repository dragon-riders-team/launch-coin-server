#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
echo "Using config path: $SCRIPTPATH"

docker run \
  --name nginx_proxy \
  -d --rm \
  -v $SCRIPTPATH:/etc/nginx/conf.d \
  --net host \
  nginx

