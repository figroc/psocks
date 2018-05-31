#!/bin/bash

name=${1}
port=${2}
torc=${3}

function realpath {
  echo $(cd $(dirname ${1}) && pwd)
}

docker run --rm \
  --name ${name}_${port} \
  -p ${port}:22 \
  -e TOR_CC="${torc}" \
  -v $(realpath ${0})/../users/${name}.pub:/etc/ssh/authorized_keys:ro \
  -d figroc/psocks
