#!/bin/bash

host=${1}
port=${2}

ssh -fNT -i~/.ssh/id_rsa -L9050:localhost:9050 -p${port} gof@${host}
