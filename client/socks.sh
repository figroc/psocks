#!/bin/bash

host=${1}
port=${2}

socks="localhost:9050"

ssh -fNT -i~/.ssh/id_rsa -L9050:${socks} -p${port} gof@${host} \
  && echo && echo "SOCKS5 Server: ${socks}"
