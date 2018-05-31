#!/bin/bash

host=${1}
port=${2}

ssh -fNT -L9050:localhost:9050 -p${port} gof@${host}
