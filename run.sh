#!/bin/bash

. settings.sh

# set -x

# docker run --rm -it \
docker run --rm -d \
  -p ${HTTP_LISTEN_PORT}:80 \
  -e ENTITY_ID=${IDCS_APPNAME} \
  $IMGNAME

docker ps | grep $IMGNAME

open http://localhost:${HTTP_LISTEN_PORT}/protected/
