#!/bin/sh

if [ -n "${TOR_CC}" ]; then
  ( echo "StrictNodes 1"
    echo "EntryNodes ${TOR_CC}"
    echo "ExitNodes  ${TOR_CC}"
  ) >> /etc/tor/torrc.default
fi
/usr/bin/tor -f /etc/tor/torrc.default
/usr/sbin/sshd -4D -E /var/log/auth.log

exec "$@"
