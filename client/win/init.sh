#!/bin/sh

if [ ! -f ~/.ssh/id_rsa ]; then
  ssh-keygen -t rsa -b 2048
fi
cat ~/.ssh/id_rsa.pub
