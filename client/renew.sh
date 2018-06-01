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
while :; do
  if [[ -n "${ipn}" ]]; then
    echo -n scanning... && sleep 15 && echo
  fi
  ssh -i~/.ssh/id_rsa -p${port} gof@${host} /renew
  ipn=$(curl -sS --socks5 ${socks} ${echoi})
  if ! grep ${ipn} ${waste} &>/dev/null; then
    break
  fi
done

echo
echo ${ipn} | tee -a ${waste}
