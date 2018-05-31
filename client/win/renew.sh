#!/bin/bash

host=${1}
port=${2}

ssh -p${port} gof@${host} /renew
