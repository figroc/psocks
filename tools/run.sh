#!/bin/bash

if (( ${#} < 2 )); then
  echo "${0} <name> <port> [entry] [exit]" 1>&2
  exit 1
fi

cc='{au},{ca},{fr},{de},{gr},{hk},{it},{jp},{kr},{tw},{gb},{uk},{us}'

name=${1}
port=${2}
tori=${3:-${cc}}
toro=${4:-${cc}}

pub=$(cd $(dirname ${0}) && pwd)/../users/${name}.pub
chmod 644 ${pub}

docker stop ${name}_${port} &>/dev/null
docker run --rm \
  --name ${name}_${port} \
  -p ${port}:22 \
  -e TOR_CC_IN="${tori}" \
  -e TOR_CC_OUT="${toro}" \
  -v ${pub}:/etc/ssh/authorized_keys:ro \
  -d figroc/psocks
