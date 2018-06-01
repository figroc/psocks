#!/bin/sh

torrc=/etc/tor/torrc.default
if [ -n "${TOR_CC_IN}" ]; then
  echo "EntryNodes ${TOR_CC_IN}" >> ${torrc}
fi
if [ -n "${TOR_CC_OUT}" ]; then
  echo "ExitNodes ${TOR_CC_OUT}" >> ${torrc}
fi
/usr/bin/tor -f ${torrc}
/usr/sbin/sshd -4D -E /var/log/auth.log

exec "$@"
