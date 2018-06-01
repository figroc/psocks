#!/bin/bash

if (( ${#} != 2 )); then
  echo "${0} <host> <ip>" 1>&2
  exit 1
fi

host=${1}
port=${2}

waste=~/waste.ip
socks="localhost:9050"
echoi="http://ipecho.net/plain"

set -e

ssh -fNT -i~/.ssh/id_rsa \
    -L9050:${socks} \
    -oExitOnForwardFailure=yes \
    -oServerAliveInterval=30 \
    -oServerAliveCountMax=5 \
    -p${port} gof@${host} \
  && echo && echo "socks5://${socks}" && echo

ipn=$(curl -sS --socks5 ${socks} ${echoi})
if grep ${ipn} ${waste} &>/dev/null; then
  unset ipn && echo scanning...
  source $(dirname ${0})/renew.sh
else
  echo ${ipn}
fi
