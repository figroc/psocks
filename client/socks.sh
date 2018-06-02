#!/bin/bash

if (( ${#} != 2 )); then
  echo "${0} <host> <port>" 1>&2
  exit 1
fi

host=${1}
port=${2}

waste=~/waste.ip
socks="localhost:9050"
echoi="http://ipecho.net/plain"

set -e

while :; do
  echo renew...
  ssh -i~/.ssh/id_rsa \
      -p${port} gof@${host} \
      "/renew"
  sleep 7
  ipn=$(ssh -i~/.ssh/id_rsa \
            -p${port} gof@${host} \
            "curl -sS --socks5 ${socks} ${echoi}")
  if ! grep ${ipn} ${waste} &>/dev/null; then
    break
  fi
done

echo
echo ${ipn} | tee -a ${waste}
echo

ssh -i~/.ssh/id_rsa \
    -L9050:${socks} \
    -oExitOnForwardFailure=yes \
    -oServerAliveInterval=30 \
    -oServerAliveCountMax=5 \
    -p${port} gof@${host} \
    "echo socks5://${socks} && sleep 365d"
