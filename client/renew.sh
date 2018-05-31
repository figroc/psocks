#!/bin/bash

host=${1}
port=${2}

ssh -i~/.ssh/id_rsa -p${port} gof@${host} /renew
echo
curl -sS --socks5 localhost:9050 http://ipecho.net/plain
echo
