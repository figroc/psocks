#!/bin/bash

if (( ${#} < 1 )); then
  echo "${0} <host:port> [local-port]" 1>&2
  exit 1
fi

rhost=${1%%:*}
rport=${1##*:}
if [[ "${rhost}" == "${rport}" ]]; then
  echo "<host:port> invalid: ${1}" 1>&2
  exit 1
fi

lhost=${2%%:*}
lport=${2##*:}
if [[ "${lhost}" == "${lport}" ]]; then
  lhost="localhost"
fi
if [[ -z "${lport}" ]]; then
  lport="9050"
fi

rsocks="localhost:9050"
lsocks="${lhost}:${lport}"

waste=~/waste.ip
echoi="http://ipecho.net/plain"

set -e

while :; do
  ssh -i~/.ssh/id_rsa \
      -p${rport} gof@${rhost} \
      "/renew" | \
      grep -Fv "250 closing connection"
  echo -n waiting... && sleep 7 && echo
  ipn=$(ssh -i~/.ssh/id_rsa \
            -p${rport} gof@${rhost} \
            "curl -sS --socks5 ${rsocks} ${echoi}")
  if ! grep ${ipn} ${waste} &>/dev/null; then
    break
  fi
done

echo
echo -n "ExitIP: " && echo ${ipn} | tee -a ${waste}
echo

ssh -i~/.ssh/id_rsa \
    -L${lsocks}:${rsocks} \
    -oExitOnForwardFailure=yes \
    -oServerAliveInterval=30 \
    -oServerAliveCountMax=5 \
    -p${rport} gof@${rhost} \
    "echo socks5://${lsocks} && echo && echo 'press <Ctrl-C> to quit' && sleep 365d"
