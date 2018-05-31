#!/bin/bash

host=${1}
port=${2}

ssh -i~/.ssh/id_rsa -p${port} gof@${host} /renew
