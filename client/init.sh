#!/bin/bash

if [[ ! -f ~/.ssh/id_rsa ]]; then
  ssh-keygen -t rsa -b 2048
fi
echo
echo
echo "*******************************"
echo "send following to administrator"
echo "*******************************"
cat ~/.ssh/id_rsa.pub
