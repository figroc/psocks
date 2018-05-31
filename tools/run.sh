#!/bin/bash

name=${1}
port=${2}
torc=${3}

pub=$(cd $(dirname ${0}) && pwd)/../users/${name}.pub
chmod 644 ${pub}

docker run --rm \
  --name ${name}_${port} \
  -p ${port}:22 \
  -e TOR_CC="${torc}" \
  -v ${pub}:/etc/ssh/authorized_keys:ro \
  -d figroc/psocks
